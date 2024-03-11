// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_drawer_item.g.dart';

class HomeDrawerItem extends EnumClass {
  static Serializer<HomeDrawerItem> get serializer =>
      _$homeDrawerItemSerializer;

  static BuiltSet<HomeDrawerItem> get values => _$values;

  static HomeDrawerItem valueOf(String name) => _$valueOf(name);

  static HomeDrawerItem valueFromWireName(String name) {
    final wn = _$HomeDrawerItemSerializer._fromWire[name];
    return _$valueOf(wn ?? name);
  }

  @BuiltValueEnumConst(fallback: true)
  static const HomeDrawerItem dashboard = _$dashboard;
  @BuiltValueEnumConst(wireName: 'schedule-meetings')
  static const HomeDrawerItem scheduleMeetings = _$scheduleMeetings;
  @BuiltValueEnumConst(wireName: 'meeting-management')
  static const HomeDrawerItem meetingManagement = _$meetingManagement;
  static const HomeDrawerItem sessions = _$sessions;
  @BuiltValueEnumConst(wireName: 'my-agenda')
  static const HomeDrawerItem myAgenda = _$myAgenda;
  static const HomeDrawerItem speakers = _$speakers;
  static const HomeDrawerItem exhibitors = _$exhibitors;
  static const HomeDrawerItem sponsors = _$sponsors;
  static const HomeDrawerItem messages = _$messages;
  static const HomeDrawerItem profile = _$profile;
  static const HomeDrawerItem organization = _$organization;
  @BuiltValueEnumConst(wireName: 'lead-scanner')
  static const HomeDrawerItem leadScanner = _$leadScanner;
  @BuiltValueEnumConst(wireName: 'feeds')
  static const HomeDrawerItem feeds = _$feeds;

  const HomeDrawerItem._(String name) : super(name);

  String get wireName {
    final wn = _$HomeDrawerItemSerializer._toWire[name];
    return wn == null ? name : wn.toString();
  }
}
