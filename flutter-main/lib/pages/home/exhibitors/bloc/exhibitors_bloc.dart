import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/response/api_response.dart';
import '../../../../services/exhibitor_service.dart';
import '../../../../widgets/cubit.dart';
import 'exhibitors_state.dart';

class ExhibitorsBloc extends WCCubit<ExhibitorsState> {
  ExhibitorsBloc() : super(ExhibitorsState()) {
    getExhibitors();
  }

  factory ExhibitorsBloc.of(final BuildContext context) =>
      BlocProvider.of<ExhibitorsBloc>(context);

  void updateSearch(final String search) {
    emit(state.rebuild((final b) => b.exhibitorsSearch = search));
    getExhibitors();
  }

  Future<void> getExhibitors() async {
    emit(
      state.rebuild(
        (final b) => b
          ..exhibitorsApi.isApiInProgress = true
          ..exhibitorsApi.error = null
          ..exhibitorsApi.data = null,
      ),
    );

    try {
      final exhibitors =
          await exhibitorService.getExhibitors(search: state.exhibitorsSearch);
      emit(state.rebuild((final b) => b.exhibitorsApi.data = exhibitors));
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.exhibitorsApi.error = metaData.message),
      );
    }
    emit(state.rebuild((final b) => b.exhibitorsApi.isApiInProgress = false));
  }
}
