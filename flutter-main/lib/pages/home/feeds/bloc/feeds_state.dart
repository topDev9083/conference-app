import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/data/feed_data.dart';
import '../../../../models/states/api_state.dart';

part 'feeds_state.g.dart';

abstract class FeedsState implements Built<FeedsState, FeedsStateBuilder> {
  factory FeedsState([
    final void Function(FeedsStateBuilder) updates,
  ]) = _$FeedsState;

  FeedsState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final FeedsStateBuilder b) => b..createPostText = '';

  String get createPostText;

  XFile? get createPostImage;

  ApiState<void> get createPostApi;

  ApiState<BuiltList<FeedData>> get getFeedsApi;

  BuiltMap<int, ApiState<void>> get likeUnlikeFeedApi;

  BuiltMap<int, ApiState<void>> get watchSnoozeFeedApi;
}
