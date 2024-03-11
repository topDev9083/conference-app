// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'announcement_send_as.g.dart';

class AnnouncementSendAs extends EnumClass {
  static Serializer<AnnouncementSendAs> get serializer =>
      _$announcementSendAsSerializer;

  static BuiltSet<AnnouncementSendAs> get values => _$values;

  static AnnouncementSendAs valueOf(String name) => _$valueOf(name);

  static const AnnouncementSendAs email = _$email;
  static const AnnouncementSendAs pushNotification = _$pushNotification;

  const AnnouncementSendAs._(String name) : super(name);
}
