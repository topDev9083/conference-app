// flutter pub run build_runner build --delete-conflicting-outputs

// ignore: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'data/agenda_data.dart';
import 'data/announcement_data.dart';
import 'data/app_config_data.dart';
import 'data/country_data.dart';
import 'data/custom_column_data.dart';
import 'data/custom_field_data.dart';
import 'data/dashboard_info_data.dart';
import 'data/document_data.dart';
import 'data/event_data.dart';
import 'data/exhibitor_data.dart';
import 'data/feed_comment_data.dart';
import 'data/feed_data.dart';
import 'data/group_data.dart';
import 'data/grouped_time_slots_data.dart';
import 'data/map_data.dart';
import 'data/map_location_data.dart';
import 'data/meeting_data.dart';
import 'data/message_data.dart';
import 'data/meta_data.dart';
import 'data/notification_data.dart';
import 'data/organization_data.dart';
import 'data/role_data.dart';
import 'data/schedule_data.dart';
import 'data/send_text_message_data.dart';
import 'data/session_data.dart';
import 'data/session_user_data.dart';
import 'data/sponsor_data.dart';
import 'data/sponsorship_level_data.dart';
import 'data/table_data.dart';
import 'data/time_slot_data.dart';
import 'data/time_zone_data.dart';
import 'data/track_data.dart';
import 'data/user_data.dart';
import 'data/user_occupancy_data.dart';
import 'data/user_permission_data.dart';
import 'enums/announcement_send_as.dart';
import 'enums/announcement_send_to.dart';
import 'enums/custom_field_type.dart';
import 'enums/home_menu_item.dart';
import 'enums/meeting_status.dart';
import 'enums/message_type.dart';
import 'enums/sort_by.dart';
import 'enums/table_type.dart';
import 'serializers/color_serializer.dart';

part 'serializers.g.dart';

@SerializersFor([
  // data
  MetaData,
  UserData,
  GroupData,
  RoleData,
  AnnouncementData,
  CountryData,
  CustomFieldData,
  DocumentData,
  EventData,
  TimeZoneData,
  ExhibitorData,
  OrganizationData,
  MapData,
  MapLocationData,
  MeetingData,
  ScheduleData,
  TableData,
  TimeSlotData,
  MessageData,
  SessionData,
  SessionUserData,
  TrackData,
  SponsorData,
  SponsorshipLevelData,
  CustomColumnData,
  NotificationData,
  SendTextMessageData,
  UserOccupancyData,
  AgendaData,
  DashboardInfoData,
  GroupedTimeSlotsData,
  UserPermissionData,
  AppConfigData,
  FeedData,
  FeedCommentData,
  // enums
  AnnouncementSendAs,
  AnnouncementSendTo,
  CustomFieldType,
  MeetingStatus,
  TableType,
  MessageType,
  HomeMenuItem,
  SortBy,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..add(ColorSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
