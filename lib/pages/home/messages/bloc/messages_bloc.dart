import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../models/data/message_data.dart';
import '../../../../models/data/user_data.dart';
import '../../../../models/params/pagination_param.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/socket_service.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/dio.dart';
import '../../../../widgets/cubit.dart';
import 'messages_state.dart';

class MessagesBloc extends WCCubit<MessagesState> {
  CancelToken? _searchUsersCancelToken;
  StreamSubscription? _onMessageSub;
  StreamSubscription? _onUsersOnlineSub;
  int profileId;

  MessagesBloc({
    required this.profileId,
  }) : super(MessagesState()) {
    searchUsers();
    _onMessageSub = socketService.onMessage.listen(_onMessageReceived);
    _onUsersOnlineSub = socketService.onUsersOnline.listen(_onUsersOnline);
  }

  factory MessagesBloc.of(final BuildContext context) =>
      BlocProvider.of<MessagesBloc>(context);

  @override
  Future<void> close() {
    _onMessageSub?.cancel();
    _onUsersOnlineSub?.cancel();
    return super.close();
  }

  void updateSearch(final String search) {
    emit(state.rebuild((final b) => b.usersSearch = search));
    searchUsers();
  }

  void resetUnreadCount(final int userId) {
    final index =
        state.usersApi.data?.indexWhere((final user) => user.id == userId) ??
            -1;
    if (index.isNegative) {
      return;
    }
    final user = state.usersApi.data![index];
    if (user.unreadMessagesCount == 0) {
      return;
    }
    emit(
      state.rebuild(
        (final b) => b.usersApi.data = state.usersApi.data!.rebuild(
          (final bData) => bData[index] =
              user.rebuild((final bUser) => bUser.unreadMessagesCount = 0),
        ),
      ),
    );
  }

  Future<void> searchUsers([final int offset = 0]) async {
    cancelDioToken(_searchUsersCancelToken);
    var newState = state.rebuild((final b) {
      b.usersApi
        ..error = null
        ..isApiInProgress = true;
      if (offset == 0) {
        b.usersApi.data = null;
      }
    });
    emit(newState);
    try {
      _searchUsersCancelToken = CancelToken();
      var users = await userService.searchUsersForMessaging(
        search: state.usersSearch,
        cancelToken: _searchUsersCancelToken,
        pagination: PaginationParam(
          offset: offset,
        ),
      );
      final onlineUserIds = socketService.onUsersOnline.value;
      users = users.rebuild((final bUsers) {
        for (int i = 0; i < bUsers.length; i++) {
          bUsers[i] = bUsers[i].rebuild(
            (final bUser) => bUser.isOnline = onlineUserIds.contains(bUser.id),
          );
        }
      });
      newState = newState.rebuild((final b) {
        b.usersApi.isApiPaginationEnabled = users.length >= RECORDS_LIMIT;
        if (offset == 0 || b.usersApi.data == null) {
          b.usersApi.data = users;
        } else {
          b.usersApi.data =
              b.usersApi.data!.rebuild((final bData) => bData.addAll(users));
        }
      });
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        newState =
            newState.rebuild((final b) => b.usersApi.error = metaData.message);
      }
    }
    emit(newState);
  }

  Future<void> _onMessageReceived(final MessageData message) async {
    final userId =
        message.fromUserId == profileId ? message.toUserId : message.fromUserId;
    var users = state.usersApi.data;
    if (users == null) {
      return;
    }
    final userIndex = users.indexWhere((final user) => user.id == userId);
    UserData? user;
    if (userIndex != -1) {
      user = users[userIndex];
    } else {
      try {
        user = await userService.getUserById(userId);
        user = user.rebuild(
          (final bUser) {
            if (message.fromUserId == profileId) {
              bUser.unreadMessagesCount = 0;
            } else {
              bUser.unreadMessagesCount = 1;
            }
          },
        );
      } catch (_) {}
    }
    if (user != null) {
      user = user.rebuild(
        (final b) => b
          ..lastMessage = message.message
          ..lastMessageCreatedOn = message.createdOn,
      );
      users = users.rebuild((final bUsers) {
        if (userIndex >= 0) {
          bUsers.removeAt(userIndex);
        }
        bUsers.insert(0, user!);
      });
      emit(state.rebuild((final b) => b.usersApi.data = users));
    }
  }

  Future<void> _onUsersOnline(final BuiltSet<int> userIds) async {
    if (state.usersApi.data == null) {
      return;
    }
    emit(
      state.rebuild(
        (final b) =>
            b.usersApi.data = state.usersApi.data!.rebuild((final bData) {
          for (var i = 0; i < bData.length; i++) {
            bData[i] = bData[i].rebuild(
              (final bUser) => bUser.isOnline = userIds.contains(bUser.id),
            );
          }
        }),
      ),
    );
  }
}
