import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/response/api_response.dart';
import '../../../../models/states/api_state.dart';
import '../../../../services/feed_service.dart';
import '../../../../utils/cubit_utils.dart';
import '../../../../widgets/cubit.dart';
import 'feeds_state.dart';

class FeedsBloc extends BVCubit<FeedsState, FeedsStateBuilder> {
  FeedsBloc() : super(FeedsState()) {
    getFeeds();
  }

  factory FeedsBloc.of(final BuildContext context) =>
      BlocProvider.of<FeedsBloc>(context);

  void updateCreateFeedText(final String text) {
    emit(
      state.rebuild(
        (final b) => b.createPostText = text,
      ),
    );
  }

  void updateCreateFeedImage(final XFile? image) {
    emit(
      state.rebuild(
        (final b) => b.createPostImage = image,
      ),
    );
  }

  Future<bool> createFeed() async {
    var isSuccess = false;
    emit(
      state.rebuild(
        (final b) => b.createPostApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final feed = await feedService.createFeed(
        text: state.createPostText.trim().isEmpty ? null : state.createPostText,
        image: state.createPostImage,
      );
      emit(
        state.rebuild(
          (final b) {
            final newFeeds = state.getFeedsApi.data?.toBuilder();
            newFeeds?.insert(0, feed);
            b.getFeedsApi.data = newFeeds?.build();
          },
        ),
      );
      isSuccess = true;
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.createPostApi.error = metaData.toString(),
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.createPostApi.isApiInProgress = false,
      ),
    );
    return isSuccess;
  }

  Future<void> getFeeds() async {
    emit(
      state.rebuild(
        (final b) => b.getFeedsApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final data = await feedService.getFeeds();
      emit(
        state.rebuild(
          (final b) => b.getFeedsApi.data = data,
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.getFeedsApi.error = metaData.toString(),
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.getFeedsApi.isApiInProgress = false,
      ),
    );
  }

  Future<void> likeOrUnlikeFeed(final int feedId, final bool isLike) async {
    ApiState<void> getApiState() {
      return state.likeUnlikeFeedApi[feedId] ?? ApiState<void>();
    }

    void updateApiState(final ApiState<void> apiState) {
      emit(
        state.rebuild(
          (final b) => b.likeUnlikeFeedApi[feedId] = apiState,
        ),
      );
    }

    updateApiState(
      getApiState().rebuild(
        (final b) => b
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final feed = await feedService.likeOrUnlikeFeedById(feedId, isLike);
      emit(
        state.rebuild(
          (final b) {
            final feeds = state.getFeedsApi.data;
            final index = feeds?.indexWhere((final f) => f.id == feedId) ?? -1;
            if (index.isNegative) {
              return;
            }
            final bFeeds = feeds!.toBuilder();
            bFeeds[index] = feed;
            b.getFeedsApi.data = bFeeds.build();
          },
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      updateApiState(
        getApiState().rebuild(
          (final b) => b..error = metaData.toString(),
        ),
      );
    }
    updateApiState(
      getApiState().rebuild((final b) => b.isApiInProgress = false),
    );
  }

  Future<void> watchSnoozeFeed(final int feedId, final bool watch) {
    return CubitUtils.makeApiCall<FeedsState, FeedsStateBuilder, void>(
      cubit: this,
      apiState: state.watchSnoozeFeedApi[feedId] ?? ApiState<void>(),
      updateApiState: (final b, final apiState) =>
          b.watchSnoozeFeedApi[feedId] = apiState,
      callApi: () async {
        final feed = await feedService.watchSnoozeFeed(feedId, watch);
        final index = state.getFeedsApi.data?.indexWhere(
              (final feed) => feed.id == feedId,
            ) ??
            -1;
        if (index.isNegative) {
          return;
        }
        emit(
          state.rebuild(
            (final b) => b.getFeedsApi.data = b.getFeedsApi.data
                ?.rebuild((final bData) => bData[index] = feed),
          ),
        );
      },
    );
  }

  void markFeedAsWatching(final int feedId) {
    final index =
        state.getFeedsApi.data?.indexWhere((final f) => f.id == feedId) ?? -1;
    if (index.isNegative) {
      return;
    }
    emit(
      state.rebuild(
        (final b) => b.getFeedsApi.data = b.getFeedsApi.data?.rebuild(
          (final bData) => bData[index] = bData[index].rebuild(
            (final bFeed) => bFeed.isWatching = true,
          ),
        ),
      ),
    );
  }
}
