import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/data/grouped_sponsors_data.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/sponsor_service.dart';
import '../../../../widgets/cubit.dart';
import 'sponsors_state.dart';

class SponsorsBloc extends WCCubit<SponsorsState> {
  SponsorsBloc() : super(SponsorsState()) {
    getSponsors();
  }

  factory SponsorsBloc.of(final BuildContext context) =>
      BlocProvider.of<SponsorsBloc>(context);

  void funSponsor(final String moveTo) {
    emit(state.rebuild((final b) => b.moveTosponsor = moveTo));
    print(state.moveTosponsor);
  }

  Future<void> getSponsors() async {
    emit(
      state.rebuild(
        (final b) => b.getSponsorsApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final sponsors = await sponsorService.getSponsors();
      emit(
        state.rebuild(
          (final b) => b
            ..getSponsorsApi.data = sponsors
            ..groupedSponsors
                .replace(GroupedSponsorsData.fromSponsors(sponsors)),
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.getSponsorsApi.error = metaData.message),
      );
    }
    emit(state.rebuild((final b) => b.getSponsorsApi.isApiInProgress = false));
  }
}
