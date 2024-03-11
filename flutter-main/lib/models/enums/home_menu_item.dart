// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_menu_item.g.dart';

class HomeMenuItem extends EnumClass {
  static Serializer<HomeMenuItem> get serializer => _$homeMenuItemSerializer;

  static BuiltSet<HomeMenuItem> get values => _$values;

  static HomeMenuItem valueOf(String name) => _$valueOf(name);

  static const HomeMenuItem dashboard = _$dashboard;
  static const HomeMenuItem scheduleMeetings = _$scheduleMeetings;
  static const HomeMenuItem myAgenda = _$myAgenda;
  static const HomeMenuItem messages = _$messages;
  static const HomeMenuItem more = _$more;

  const HomeMenuItem._(String name) : super(name);
}
