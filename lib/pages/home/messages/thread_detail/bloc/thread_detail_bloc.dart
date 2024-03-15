import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/home_drawer_bloc.dart';
import '../../../../../models/data/message_data.dart';
import '../../../../../models/data/send_text_message_data.dart';
import '../../../../../models/enums/message_type.dart';
import '../../../../../models/response/api_response.dart';
import '../../../../../services/message_service.dart';
import '../../../../../services/socket_service.dart';
import '../../../../../services/user_service.dart';
import '../../../../../utils/dio.dart';
import '../../../../../utils/pedantic.dart';
import '../../../../../widgets/cubit.dart';
import 'thread_detail_state.dart';

class ThreadDetailBloc extends WCCubit<ThreadDetailState> {
  StreamSubscription? _subOnMessage;
  final HomeDrawerBloc homeDrawerBloc;
  CancelToken? _getUserCancelToken;
  CancelToken? _getMessagesCancelToken;

  ThreadDetailBloc(
    final int userId, {
    required this.homeDrawerBloc,
  }) : super(ThreadDetailState((final b) => b.userId = userId)) {
    getUser();
    socketService.selectedMessageUserId = userId;
    getMessages();
  }

  factory ThreadDetailBloc.of(final BuildContext context) =>
      BlocProvider.of<ThreadDetailBloc>(context);

  @override
  Future<void> close() {
    socketService.selectedMessageUserId = null;
    _subOnMessage?.cancel();
    return super.close();
  }

  void updateUserId(final int userId) {
    socketService.selectedMessageUserId = userId;
    emit(
      state.rebuild(
        (final b) => b
          ..userId = userId
          ..userApi.data = null
          ..messagesApi = null,
      ),
    );
    getUser();
    getMessages();
  }

  Future<void> getUser() async {
    cancelDioToken(_getUserCancelToken);
    emit(
      state.rebuild(
        (final b) => b.userApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      _getUserCancelToken = CancelToken();
      final user = await userService.getUserById(
        state.userId,
        cancelToken: _getUserCancelToken,
      );
      emit(state.rebuild((final b) => b.userApi.data = user));
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(state.rebuild((final b) => b.userApi.error = metaData.message));
      }
    }
    emit(state.rebuild((final b) => b.userApi.isApiInProgress = false));
  }

  Future<void> getMessages() async {
    cancelDioToken(_getMessagesCancelToken);
    await _subOnMessage?.cancel();
    emit(
      state.rebuild(
        (final b) => b.messagesApi
          ..isApiInProgress = true
          ..error = null
          ..data = null,
      ),
    );
    try {
      _getMessagesCancelToken = CancelToken();
      final messages = await messageService.getMessagesByUserId(
        state.userId,
        cancelToken: _getMessagesCancelToken,
      );
      emit(state.rebuild((final b) => b.messagesApi.data = messages));
      _subOnMessage = socketService.onMessage.listen(_onMessageReceived);
      unAwaited(homeDrawerBloc.getUnreadMessageCount());
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild((final b) => b.messagesApi.error = metaData.message),
        );
      }
    }
    emit(state.rebuild((final b) => b.messagesApi.isApiInProgress = false));
  }

  void updateMessageText(final String message) {
    emit(state.rebuild((final b) => b.message = message));
  }

  void sendMessage() {
    socketService.sendMessage(
      SendTextMessageData(
        (final b) => b
          ..toUserId = state.userId
          ..message = state.message
          ..type = MessageType.text,
      ),
    );
    emit(state.rebuild((final b) => b.message = ''));
  }

  Future<void> sendAttachment({
    required final PlatformFile file,
    required final MessageType type,
  }) async {
    emit(
      state.rebuild(
        (final b) => b.attachmentApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      await messageService.sendAttachment(
        toUserId: state.userId,
        file: file,
        type: type,
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.attachmentApi.error = metaData.message),
      );
    }
    emit(state.rebuild((final b) => b.attachmentApi.isApiInProgress = false));
  }

  void _onMessageReceived(final MessageData message) {
    if (![message.fromUserId, message.toUserId].contains(state.userId)) {
      return;
    }
    emit(
      state.rebuild(
        (final b) => b.messagesApi.data = state.messagesApi.data!
            .rebuild((final bData) => bData.insert(0, message)),
      ),
    );

    if (message.fromUserId == state.userId) {
      socketService.markMessagesAsRead(state.userId);
    }
  }
}
