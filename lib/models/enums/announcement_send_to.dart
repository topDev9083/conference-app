// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'announcement_send_to.g.dart';

class AnnouncementSendTo extends EnumClass {
  static Serializer<AnnouncementSendTo> get serializer =>
      _$announcementSendToSerializer;

  static BuiltSet<AnnouncementSendTo> get values => _$values;

  static AnnouncementSendTo valueOf(String name) => _$valueOf(name);

  static const AnnouncementSendTo all = _$all;
  static const AnnouncementSendTo groups = _$groups;
  static const AnnouncementSendTo individuals = _$individuals;

  const AnnouncementSendTo._(String name) : super(name);
}
