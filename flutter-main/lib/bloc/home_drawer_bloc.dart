import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/data/message_data.dart';
import '../models/response/api_response.dart';
import '../services/message_service.dart';
import '../services/socket_service.dart';
import '../widgets/cubit.dart';
import 'profile_bloc.dart';
import 'state/home_drawer_state.dart';

class HomeDrawerBloc extends WCCubit<HomeDrawerState> {
  StreamSubscription? _subOnConnectionChanged;
  StreamSubscription? _subOnMessage;
  ProfileBloc profileBloc;

  HomeDrawerBloc({
    required this.profileBloc,
  }) : super(HomeDrawerState()) {
    _subOnConnectionChanged =
        socketService.onConnectionChanged.listen((final isConnected) {
      if (isConnected) {
        getUnreadMessageCount();
      }
    });
    _subOnMessage = socketService.onMessage.listen(_onMessageReceived);
  }

  factory HomeDrawerBloc.of(final BuildContext context) =>
      BlocProvider.of<HomeDrawerBloc>(context);

  @override
  Future<void> close() {
    _subOnConnectionChanged?.cancel();
    _subOnMessage?.cancel();
    return super.close();
  }

  void toggleIsDesktopCollapsed() {
    emit(
      state.rebuild(
        (final b) =>
            b.isDesktopDrawerCollapsed = !state.isDesktopDrawerCollapsed,
      ),
    );
  }

  void updateEndDrawerWidget(final Widget? widget) {
    emit(state.rebuild((final b) => b.endDrawer = widget));
  }

  Future<void> getUnreadMessageCount() async {
    emit(
      state.rebuild(
        (final b) => b.unreadMessageCountApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final unreadCount = await messageService.getMessagesUnreadCount();
      emit(
        state.rebuild((final b) => b.unreadMessageCountApi.data = unreadCount),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.unreadMessageCountApi..error = metaData.message,
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.unreadMessageCountApi..isApiInProgress = false,
      ),
    );
  }

  void updateUnreadMessageCount({
    final int? count,
    final int? increment,
    final int? decrement,
  }) {
    var newCount = 0;
    if (count != null) {
      newCount = count;
    } else if (increment != null) {
      newCount = state.unreadMessageCountApi.data! + increment;
    } else if (decrement != null) {
      newCount = state.unreadMessageCountApi.data! - decrement;
    }
    emit(
      state.rebuild(
        (final b) => b.unreadMessageCountApi.data = newCount < 0 ? 0 : newCount,
      ),
    );
  }

  void _onMessageReceived(final MessageData message) {
    if (message.fromUserId == profileBloc.state?.id) {
      return;
    }
    if (message.fromUserId == socketService.selectedMessageUserId) {
      return;
    }
    updateUnreadMessageCount(
      increment: 1,
    );
  }
}
