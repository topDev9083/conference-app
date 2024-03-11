import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'user_data.dart';

part 'feed_data.g.dart';

abstract class FeedData implements Built<FeedData, FeedDataBuilder> {
  factory FeedData([
    final void Function(FeedDataBuilder) updates,
  ]) = _$FeedData;

  FeedData._();

  static Serializer<FeedData> get serializer => _$feedDataSerializer;

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final FeedDataBuilder b) => b..isWatching = false;

  int get id;

  String? get text;

  String? get imageUrl;

  int? get createdByUserId;

  int? get createdByAdminId;

  UserData? get createdByUser;

  int get likesCount;

  int get commentsCount;

  bool get isLiked;

  bool get isWatching;

  String get updatedOn;

  DateTime get createdOn;

  static FeedData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(
      FeedData.serializer,
      json,
    )!;
  }

  static BuiltList<FeedData> fromDynamics(final List<dynamic> list) {
    return BuiltList<FeedData>(
      list.map(
        (final json) => fromDynamic(json),
      ),
    );
  }
}
