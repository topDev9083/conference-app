import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../models/data/feed_comment_data.dart';
import '../../../models/states/api_state.dart';

part 'feed_comments_state.g.dart';

abstract class FeedCommentsState
    implements Built<FeedCommentsState, FeedCommentsStateBuilder> {
  factory FeedCommentsState([
    final void Function(FeedCommentsStateBuilder) updates,
  ]) = _$FeedCommentsState;

  FeedCommentsState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final FeedCommentsStateBuilder b) => b
    ..commentText = ''
    ..isCommentAdded = false;

  int get feedId;

  String get commentText;

  ApiState<void> get createCommentApi;

  ApiState<BuiltList<FeedCommentData>> get getCommentsApi;

  bool get isCommentAdded;
}
