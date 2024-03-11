import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/dialogs.dart';
import 'bloc/speakers_bloc.dart';
import 'bloc/speakers_state.dart';
import 'speakers_list.dart';

class SpeakersFragment extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => SpeakersBloc(),
      child: BlocListener<SpeakersBloc, SpeakersState>(
        listenWhen: (final prev, final next) {
          var hasError = false;
          next.addToAgendaApi.forEach((final sessionId, final nextApiState) {
            final prevApiState =
                prev.addToAgendaApi[sessionId] ?? ApiState<void>();
            if (prevApiState.error == null && nextApiState.error != null) {
              hasError = true;
            }
          });
          return hasError;
        },
        listener: (final _, final state) {
          state.addToAgendaApi.forEach((final sessionId, final apiState) {
            if (apiState.error != null) {
              WCDialog.showError(context, subtitle: apiState.error);
            }
          });
        },
        child: Column(
          children: [
            SizedBox(
              height: getValueForScreenType(
                context: context,
                mobile: 16,
                tablet: 18,
              ),
            ),
            _SearchField(),
            Expanded(
              child: SpeakersList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final field = TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded),
        hintText: translate(
          context,
          TranslationKeys.General_Search,
        ),
      ),
      onChanged: SpeakersBloc.of(context).updateSearch,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getValueForScreenType(
          context: context,
          mobile: 16,
          tablet: 30,
        ),
      ),
      child: ScreenTypeLayout.builder(
        mobile: (final _) => field,
        tablet: (final _) => Container(
          margin: const EdgeInsets.only(
            top: 11,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 27,
            vertical: 23,
          ),
          color: Colors.white,
          child: field,
        ),
      ),
    );
  }
}
