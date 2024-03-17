import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/country_data.dart';
import '../../../../models/data/custom_field_data.dart';
import '../../../../models/data/organization_data.dart';
import '../../../../models/data/user_data.dart';
import '../../../../models/enums/meeting_status.dart';
import '../../../../models/enums/sort_by.dart';
import '../../../../models/states/api_state.dart';

part 'schedule_meetings_state.g.dart';

abstract class ScheduleMeetingsState
    implements Built<ScheduleMeetingsState, ScheduleMeetingsStateBuilder> {
  factory ScheduleMeetingsState([
    final void Function(ScheduleMeetingsStateBuilder) updates,
  ]) = _$ScheduleMeetingsState;

  ScheduleMeetingsState._();

  static void _initializeBuilder(final ScheduleMeetingsStateBuilder b) => b
    ..attendeesSearch = ''
    ..attendeesSortBy = SortBy.namee
    ..organizationsSearch = ''
    ..countriesSearch = '';

  // attendees
  String get attendeesSearch;

  SortBy get attendeesSortBy;

  ApiState<BuiltList<UserData>> get attendeesApi;

  // organizations
  String get organizationsSearch;

  ApiState<BuiltList<OrganizationData>> get organizationsApi;

  // countries
  String get countriesSearch;

  ApiState<BuiltList<CountryData>> get countriesApi;

  // custom fields
  ApiState<BuiltList<CustomFieldData>> get customFieldsApi;

  // filters
  BuiltSet<int> get selectedCustomFieldIds;

  BuiltSet<int> get selectedCountryIds;

  BuiltSet<int> get selectedOrganizationIds;

  BuiltSet<MeetingStatus> get selectedMeetingStatues;
}
