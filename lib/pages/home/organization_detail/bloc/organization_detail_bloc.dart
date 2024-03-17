import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/data/organization_data.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/user_service.dart';
import '../../../../widgets/cubit.dart';
import 'organization_detail_state.dart';

class OrganizationDetailBloc extends WCCubit<OrganizationDetailState> {
  OrganizationDetailBloc({
    required final OrganizationData organization,
    final String? boothNumber,
  }) : super(
          OrganizationDetailState(
            (final b) => b
              ..organization.replace(organization)
              ..boothNumber = boothNumber,
          ),
        ) {
    getColleagues();
  }

  factory OrganizationDetailBloc.of(final BuildContext context) =>
      BlocProvider.of<OrganizationDetailBloc>(context);

  Future<void> getColleagues() async {
    emit(
      state.rebuild(
        (final b) => b.getColleaguesApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final users =
          await userService.getUsersByOrganizationId(state.organization.id);
      emit(state.rebuild((final b) => b.getColleaguesApi.data = users));
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.getColleaguesApi.error = metaData.message),
      );
    }
    emit(
      state.rebuild((final b) => b.getColleaguesApi.isApiInProgress = false),
    );
  }
}
