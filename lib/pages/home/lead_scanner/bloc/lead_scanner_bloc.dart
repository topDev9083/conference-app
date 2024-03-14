import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../models/data/user_data.dart';
import '../../../../models/params/pagination_param.dart';
import '../../../../models/response/api_response.dart';
import '../../../../models/states/api_state.dart';
import '../../../../services/scanned_user_service.dart';
import '../../../../utils/cubit_utils.dart';
import '../../../../utils/dio.dart';
import '../../../../widgets/cubit.dart';
import 'lead_scanner_state.dart';

class LeadScannerBloc
    extends BVCubit<LeadScannerState, LeadScannerStateBuilder> {
  CancelToken? _getUsersCancelToken;

  LeadScannerBloc() : super(LeadScannerState()) {
    getUsers();
  }

  factory LeadScannerBloc.of(final BuildContext context) =>
      BlocProvider.of<LeadScannerBloc>(context);

  Future<void> getUsers([final int offset = 0]) async {
    if (!state.getUsersApi.isApiPaginationEnabled && offset != 0) {
      return;
    }
    cancelDioToken(_getUsersCancelToken);
    emit(
      state.rebuild((final b) {
        b
          ..getUsersApi.isApiInProgress = true
          ..getUsersApi.error = null
          ..getUsersApi.isApiPaginationEnabled = true;
        if (offset == 0) {
          b.getUsersApi.data = null;
        }
      }),
    );
    try {
      _getUsersCancelToken = CancelToken();
      final newUsers = await scannedUserService.getUsers(
        pagination: PaginationParam(offset: offset),
        cancelToken: _getUsersCancelToken,
      );
      ListBuilder<UserData> users =
          state.getUsersApi.data?.toBuilder() ?? ListBuilder();
      if (offset == 0) {
        users = newUsers.toBuilder();
      } else {
        users.addAll(newUsers);
      }
      emit(
        state.rebuild(
          (final b) => b
            ..getUsersApi.data = users.build()
            ..getUsersApi.isApiPaginationEnabled =
                newUsers.length >= RECORDS_LIMIT,
        ),
      );
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild((final b) => b.getUsersApi.error = metaData.message),
        );
      }
    }
    emit(state.rebuild((final b) => b.getUsersApi.isApiInProgress = false));
  }

  Future<void> addUser(final String qrCode) async {
    emit(
      state.rebuild(
        (final b) => b.addUserApi
          ..isApiInProgress = true
          ..error = null
          ..data = null,
      ),
    );
    try {
      final user = await scannedUserService.addUser(qrCode);
      emit(state.rebuild((final b) => b.addUserApi.data = user));
      emit(
        state.rebuild(
          (final b) => b.getUsersApi.data =
              state.getUsersApi.data?.rebuild((final bData) => bData.add(user)),
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(state.rebuild((final b) => b.addUserApi.error = metaData.message));
    }
    emit(state.rebuild((final b) => b.addUserApi.isApiInProgress = false));
  }

  Future<void> deleteUser(final int userId) async {
    var apiState = state.deleteUserApi[userId] ?? ApiState<void>();
    apiState = apiState.rebuild(
      (final b) => b
        ..isApiInProgress = true
        ..error = null,
    );
    emit(state.rebuild((final b) => b.deleteUserApi[userId] = apiState));
    try {
      await scannedUserService.deleteUser(userId);
      emit(
        state.rebuild(
          (final b) => b.getUsersApi.data = state.getUsersApi.data?.rebuild(
            (final bData) =>
                bData.removeWhere((final user) => user.id == userId),
          ),
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      apiState = apiState.rebuild((final b) => b.error = metaData.message);
      emit(state.rebuild((final b) => b.deleteUserApi[userId] = apiState));
    }
    emit(state.rebuild((final b) => b.deleteUserApi.remove(userId)));
  }

  Future<void> getUsersCSV() {
    return CubitUtils.makeApiCall<LeadScannerState, LeadScannerStateBuilder,
        String>(
      makeDataNullAtStart: true,
      cubit: this,
      apiState: state.getUsersCsvApi,
      updateApiState: (final b, final apiState) => b.getUsersCsvApi.replace(
        apiState,
      ),
      callApi: () => scannedUserService.getUsersCsv(),
    );
  }
}
