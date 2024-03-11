import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/data/session_data.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/dashboard_service.dart';
import '../../../../widgets/cubit.dart';
import 'dashboard_state.dart';

class DashboardBloc extends WCCubit<DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    getDashboardInfo();
  }

  factory DashboardBloc.of(final BuildContext context) =>
      BlocProvider.of<DashboardBloc>(context);

  Future<void> getDashboardInfo() async {
    emit(
      state.rebuild(
        (final b) => b
          ..api.isApiInProgress = true
          ..api.error = null,
      ),
    );
    try {
      final dashboardInfo = await dashboardService.getDashboardInfo();
      emit(state.rebuild((final b) => b.api.data = dashboardInfo));
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(state.rebuild((final b) => b.api.error = metaData.message));
    }
    emit(state.rebuild((final b) => b.api.isApiInProgress = false));
  }

  void updateSession(final SessionData session) {
    if (state.api.data == null) {
      return;
    }
    final index =
        state.api.data!.sessions.indexWhere((final s) => s.id == session.id);

    if (index < 0) {
      return;
    }
    emit(
      state.rebuild(
        (final b) => b.api.data = state.api.data!
            .rebuild((final bData) => bData.sessions[index] = session),
      ),
    );
  }
}
