import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/response/api_response.dart';
import '../../../services/user_occupancy_service.dart';
import '../../../widgets/cubit.dart';
import 'add_user_occupancy_state.dart';

class AddUserOccupancyBloc extends WCCubit<AddUserOccupancyState> {
  AddUserOccupancyBloc({final DateTime? date})
      : super(AddUserOccupancyState((final b) => b.date = date));

  factory AddUserOccupancyBloc.of(final BuildContext context) =>
      BlocProvider.of<AddUserOccupancyBloc>(context);

  void updateDate(final DateTime date) {
    emit(
      state.rebuild(
        (final b) => b
          ..date = date
          ..addUserOccupancyApi.error = null,
      ),
    );
  }

  void updateStartTime(final TimeOfDay startTime) {
    emit(
      state.rebuild(
        (final b) => b
          ..startTime = startTime
          ..addUserOccupancyApi.error = null,
      ),
    );
  }

  void updateEndTime(final TimeOfDay endTime) {
    emit(
      state.rebuild(
        (final b) => b
          ..endTime = endTime
          ..addUserOccupancyApi.error = null,
      ),
    );
  }

  void updateReason(final String? reason) {
    emit(
      state.rebuild(
        (final b) => b
          ..reason = reason?.trim()
          ..addUserOccupancyApi.error = null,
      ),
    );
  }

  Future<void> addCustomAgenda() async {
    emit(
      state.rebuild(
        (final b) => b.addUserOccupancyApi
          ..isApiInProgress = true
          ..error = null
          ..data = null,
      ),
    );
    try {
      final occupancy = await userOccupancyService.createUserOccupancy(
        startDate: state.date!.add(
          Duration(
            hours: state.startTime!.hour,
            minutes: state.startTime!.minute,
          ),
        ),
        endDate: state.date!.add(
          Duration(
            hours: state.endTime!.hour,
            minutes: state.endTime!.minute,
          ),
        ),
        reason: state.reason.isEmpty ? null : state.reason,
      );
      emit(state.rebuild((final b) => b.addUserOccupancyApi.data = occupancy));
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.addUserOccupancyApi.error = metaData.message,
        ),
      );
    }
    emit(
      state.rebuild((final b) => b.addUserOccupancyApi.isApiInProgress = false),
    );
  }
}
