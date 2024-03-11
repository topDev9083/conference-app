import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'user_data.dart';

part 'feed_comment_data.g.dart';

abstract class FeedCommentData
    implements Built<FeedCommentData, FeedCommentDataBuilder> {
  factory FeedCommentData([
    final void Function(FeedCommentDataBuilder) updates,
  ]) = _$FeedCommentData;

  FeedCommentData._();

  static Serializer<FeedCommentData> get serializer =>
      _$feedCommentDataSerializer;

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final FeedCommentDataBuilder b) => b;

  int get id;

  String? get text;

  int? get createdByUserId;

  int? get createdByAdminId;

  UserData? get createdByUser;

  String get updatedOn;

  DateTime get createdOn;

  static FeedCommentData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(
      FeedCommentData.serializer,
      json,
    )!;
  }

  static BuiltList<FeedCommentData> fromDynamics(final List<dynamic> list) {
    return BuiltList<FeedCommentData>(
      list.map(
        (final json) => fromDynamic(json),
      ),
    );
  }
}
