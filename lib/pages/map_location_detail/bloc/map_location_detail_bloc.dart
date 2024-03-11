import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/response/api_response.dart';
import '../../../services/map_location_service.dart';
import '../../../widgets/cubit.dart';
import 'map_location_detail_state.dart';

class MapLocationDetailBloc extends WCCubit<MapLocationDetailState> {
  MapLocationDetailBloc(final int mapLocationId)
      : super(
          MapLocationDetailState(
            (final b) => b.mapLocationId = mapLocationId,
          ),
        ) {
    getMapLocationDetail();
  }

  factory MapLocationDetailBloc.of(final BuildContext context) =>
      BlocProvider.of<MapLocationDetailBloc>(context);

  Future<void> getMapLocationDetail() async {
    emit(
      state.rebuild(
        (final b) => b.mapLocationApi
          ..isApiInProgress = true
          ..data = null
          ..error = null,
      ),
    );
    try {
      final mapLocationDetail =
          await mapLocationService.getMapLocationById(state.mapLocationId);
      emit(
        state.rebuild((final b) => b.mapLocationApi..data = mapLocationDetail),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.mapLocationApi..error = metaData.message,
        ),
      );
    }
    emit(state.rebuild((final b) => b.mapLocationApi..isApiInProgress = false));
  }
}
