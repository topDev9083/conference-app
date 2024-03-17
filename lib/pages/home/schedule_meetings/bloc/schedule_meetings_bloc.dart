import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../models/data/country_data.dart';
import '../../../../models/data/custom_field_data.dart';
import '../../../../models/data/organization_data.dart';
import '../../../../models/data/user_data.dart';
import '../../../../models/enums/custom_field_type.dart';
import '../../../../models/enums/meeting_status.dart';
import '../../../../models/enums/sort_by.dart';
import '../../../../models/params/pagination_param.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/country_service.dart';
import '../../../../services/custom_field_service.dart';
import '../../../../services/organization_service.dart';
import '../../../../services/socket_service.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/dio.dart';
import '../../../../widgets/cubit.dart';
import 'schedule_meetings_state.dart';

class ScheduleMeetingsBloc extends WCCubit<ScheduleMeetingsState> {
  CancelToken? _searchUserCancelToken;
  CancelToken? _searchOrganizationCancelToken;
  CancelToken? _searchCountriesCancelToken;
  StreamSubscription? _onUsersOnlineSub;

  ScheduleMeetingsBloc() : super(ScheduleMeetingsState()) {
    searchUsers();
    searchOrganizations();
    searchCountries();
    getCustomFields();

    _onUsersOnlineSub = socketService.onUsersOnline.listen(_onUsersOnline);
  }

  factory ScheduleMeetingsBloc.of(final BuildContext context) =>
      BlocProvider.of<ScheduleMeetingsBloc>(context);

  @override
  Future<void> close() {
    _onUsersOnlineSub?.cancel();
    return super.close();
  }

  void updateAttendeesSearch(final String search) {
    emit(state.rebuild((final b) => b.attendeesSearch = search));
    searchUsers();
  }

  void updateAttendeesSortBy(final SortBy sortBy) {
    emit(state.rebuild((final b) => b.attendeesSortBy = sortBy));
    searchUsers();
  }

  void updateOrganizationsSearch(final String search) {
    emit(state.rebuild((final b) => b.organizationsSearch = search));
    searchOrganizations();
  }

  void updateCountriesSearch(final String search) {
    emit(state.rebuild((final b) => b.countriesSearch = search));
    searchCountries();
  }

  void addCustomFieldId(final int id) {
    emit(state.rebuild((final b) => b.selectedCustomFieldIds.add(id)));
    searchUsers();
  }

  void removeCustomFieldId(final int id) {
    emit(state.rebuild((final b) => b.selectedCustomFieldIds.remove(id)));
    searchUsers();
  }

  void addCountryId(final int id) {
    emit(state.rebuild((final b) => b.selectedCountryIds.add(id)));
    searchUsers();
  }

  void removeCountryId(final int id) {
    emit(state.rebuild((final b) => b.selectedCountryIds.remove(id)));
    searchUsers();
  }

  void addOrganizationId(final int id) {
    emit(state.rebuild((final b) => b.selectedOrganizationIds.add(id)));
    searchUsers();
  }

  void removeOrganizationId(final int id) {
    emit(state.rebuild((final b) => b.selectedOrganizationIds.remove(id)));
    searchUsers();
  }

  void addMeetingStatus(final MeetingStatus status) {
    emit(state.rebuild((final b) => b.selectedMeetingStatues.add(status)));
    searchUsers();
  }

  void removeMeetingStatus(final MeetingStatus status) {
    emit(state.rebuild((final b) => b.selectedMeetingStatues.remove(status)));
    searchUsers();
  }

  void clearFilters() {
    emit(
      state.rebuild((final b) {
        b
          ..selectedCustomFieldIds.clear()
          ..selectedCountryIds.clear()
          ..selectedOrganizationIds.clear()
          ..selectedMeetingStatues.clear()
          ..attendeesSortBy = SortBy.namee;
      }),
    );
    searchUsers();
  }

  BuiltList<CustomFieldData>? getCustomFieldsByTypes(
    final List<CustomFieldType> types,
  ) {
    if (state.customFieldsApi.data == null) {
      return null;
    }
    return BuiltList(
      state.customFieldsApi.data!.where(
        (final cf) => types.contains(cf.type),
      ),
    );
  }

  Future<void> searchUsers([final int offset = 0]) async {
    if (!state.attendeesApi.isApiPaginationEnabled && offset != 0) {
      return;
    }
    cancelDioToken(_searchUserCancelToken);
    emit(
      state.rebuild((final b) {
        b
          ..attendeesApi.isApiInProgress = true
          ..attendeesApi.error = null
          ..attendeesApi.isApiPaginationEnabled = true;
        if (offset == 0) {
          b.attendeesApi.data = null;
        }
      }),
    );
    try {
      _searchUserCancelToken = CancelToken();
      var newUsers = await userService.searchUsers(
        search: state.attendeesSearch,
        pagination: PaginationParam(offset: offset),
        sortBy: state.attendeesSortBy,
        selectedCustomFieldIds: state.selectedCustomFieldIds,
        selectedCountryIds: state.selectedCountryIds,
        selectedOrganizationIds: state.selectedOrganizationIds,
        selectedMeetingStatues: state.selectedMeetingStatues,
        cancelToken: _searchUserCancelToken,
      );
      final onlineUserIds = socketService.onUsersOnline.value;
      newUsers = newUsers.rebuild((final bUsers) {
        for (int i = 0; i < bUsers.length; i++) {
          bUsers[i] = bUsers[i].rebuild(
            (final bUser) => bUser.isOnline = onlineUserIds.contains(bUser.id),
          );
        }
      });
      ListBuilder<UserData> users =
          state.attendeesApi.data?.toBuilder() ?? ListBuilder();
      if (offset == 0) {
        users = newUsers.toBuilder();
      } else {
        users.addAll(newUsers);
      }
      emit(
        state.rebuild(
          (final b) => b
            ..attendeesApi.data = users.build()
            ..attendeesApi.isApiPaginationEnabled =
                newUsers.length >= RECORDS_LIMIT,
        ),
      );
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild((final b) => b.attendeesApi.error = metaData.message),
        );
      }
    }
    emit(state.rebuild((final b) => b.attendeesApi.isApiInProgress = false));
  }

  Future<void> getCustomFields() async {
    emit(
      state.rebuild(
        (final b) => b
          ..customFieldsApi.isApiInProgress = true
          ..customFieldsApi.error = null,
      ),
    );
    try {
      final customFields = await customFieldService.getCustomFields();
      emit(state.rebuild((final b) => b.customFieldsApi.data = customFields));
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.customFieldsApi.error = metaData.message),
      );
    }
    emit(state.rebuild((final b) => b.customFieldsApi.isApiInProgress = false));
  }

  Future<void> searchOrganizations([final int offset = 0]) async {
    if (!state.organizationsApi.isApiPaginationEnabled && offset != 0) {
      return;
    }
    cancelDioToken(_searchOrganizationCancelToken);
    emit(
      state.rebuild((final b) {
        b
          ..organizationsApi.isApiInProgress = true
          ..organizationsApi.error = null
          ..organizationsApi.isApiPaginationEnabled = true;
        if (offset == 0) {
          b.organizationsApi.data = null;
        }
      }),
    );

    try {
      _searchOrganizationCancelToken = CancelToken();
      final organizations = await organizationService.searchOrganizations(
        search: state.organizationsSearch,
        pagination: PaginationParam(offset: offset),
        cancelToken: _searchOrganizationCancelToken,
      );
      final ListBuilder<OrganizationData> allOrganizations = ListBuilder();
      if (offset != 0) {
        allOrganizations.addAll(state.organizationsApi.data!);
      }
      allOrganizations.addAll(organizations);
      emit(
        state.rebuild(
          (final b) => b
            ..organizationsApi.data = allOrganizations.build()
            ..organizationsApi.isApiPaginationEnabled =
                organizations.length >= RECORDS_LIMIT,
        ),
      );
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild(
            (final b) => b.organizationsApi.error = metaData.message,
          ),
        );
      }
    }
    emit(
      state.rebuild(
        (final b) => b.organizationsApi.isApiInProgress = false,
      ),
    );
  }

  Future<void> searchCountries([final int offset = 0]) async {
    if (!state.countriesApi.isApiPaginationEnabled && offset != 0) {
      return;
    }
    cancelDioToken(_searchCountriesCancelToken);
    emit(
      state.rebuild(
        (final b) {
          b
            ..countriesApi.isApiInProgress = true
            ..countriesApi.error = null
            ..countriesApi.isApiPaginationEnabled = true;
          if (offset == 0) {
            b.countriesApi.data = null;
          }
        },
      ),
    );

    try {
      _searchCountriesCancelToken = CancelToken();
      final countries = await countryService.searchCountries(
        search: state.countriesSearch,
        pagination: PaginationParam(offset: offset),
        cancelToken: _searchCountriesCancelToken,
        showUsersCount: true,
      );
      final ListBuilder<CountryData> allCountries = ListBuilder();
      if (offset != 0) {
        allCountries.addAll(state.countriesApi.data!);
      }
      allCountries.addAll(countries);
      emit(
        state.rebuild(
          (final b) => b
            ..countriesApi.data = allCountries.build()
            ..countriesApi.isApiPaginationEnabled =
                countries.length >= RECORDS_LIMIT,
        ),
      );
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild(
            (final b) => b.countriesApi.error = metaData.message,
          ),
        );
      }
    }
    emit(state.rebuild((final b) => b.countriesApi.isApiInProgress = false));
  }

  Future<void> _onUsersOnline(final BuiltSet<int> userIds) async {
    if (state.attendeesApi.data == null) {
      return;
    }
    emit(
      state.rebuild(
        (final b) => b.attendeesApi.data =
            state.attendeesApi.data!.rebuild((final bData) {
          for (var i = 0; i < bData.length; i++) {
            bData[i] = bData[i].rebuild(
              (final bUser) => bUser.isOnline = userIds.contains(bUser.id),
            );
          }
        }),
      ),
    );
  }
}
