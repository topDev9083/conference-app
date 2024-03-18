import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../widgets/connection_information.dart';
import 'bloc/speakers_bloc.dart';
import 'bloc/speakers_state.dart';
import 'speaker_item.dart';

class SpeakersList extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<SpeakersBloc, SpeakersState>(
      builder: (final _, final state) => state.speakersApi.data == null
          ? Center(
              child: ConnectionInformation(
                error: state.speakersApi.error,
                onRetry: SpeakersBloc.of(context).getSpeakers,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: getValueForScreenType(
                  context: context,
                  mobile: 16,
                  tablet: 30,
                ),
              ),
              itemBuilder: (final _, final index) =>
                  SpeakerItem(state.speakersApi.data![index]),
              itemCount: state.speakersApi.data!.length,
            ),
    );
  }
}
