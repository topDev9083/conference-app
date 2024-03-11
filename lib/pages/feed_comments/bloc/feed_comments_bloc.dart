import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/response/api_response.dart';
import '../../../services/feed_service.dart';
import '../../../widgets/cubit.dart';
import 'feed_comments_state.dart';

class FeedCommentsBloc extends WCCubit<FeedCommentsState> {
  FeedCommentsBloc({
    required final int feedId,
  }) : super(
          FeedCommentsState(
            (final b) => b..feedId = feedId,
          ),
        ) {
    getComments();
  }

  factory FeedCommentsBloc.of(final BuildContext context) =>
      BlocProvider.of<FeedCommentsBloc>(context);

  void updateCommentText(final String text) {
    emit(
      state.rebuild(
        (final b) => b.commentText = text,
      ),
    );
  }

  Future<void> getComments() async {
    emit(
      state.rebuild(
        (final b) => b.getCommentsApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final comments = await feedService.getCommentsByFeedId(state.feedId);
      emit(
        state.rebuild(
          (final b) => b.getCommentsApi.data = comments,
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.getCommentsApi.error = metaData.toString(),
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.getCommentsApi.isApiInProgress = false,
      ),
    );
  }

  Future<bool> postComment() async {
    var isSuccess = false;
    emit(
      state.rebuild(
        (final b) => b.createCommentApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final comment = await feedService.createFeedComment(
        state.feedId,
        text: state.commentText,
      );
      emit(
        state.rebuild(
          (final b) {
            b.isCommentAdded = true;
            final bComments = b.getCommentsApi.data?.toBuilder();
            bComments?.insert(0, comment);
            b.getCommentsApi.data = bComments?.build();
          },
        ),
      );
      isSuccess = true;
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.createCommentApi.error = metaData.toString(),
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.createCommentApi.isApiInProgress = false,
      ),
    );
    return isSuccess;
  }
}
