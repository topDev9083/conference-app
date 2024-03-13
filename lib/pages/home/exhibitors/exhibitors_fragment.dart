import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/fragment_padding.dart';
import 'bloc/exhibitors_bloc.dart';
import 'exhibitors_list.dart';

class ExhibitorsFragment extends StatelessWidget {
  const ExhibitorsFragment();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => ExhibitorsBloc(),
      child: FragmentPadding(
        child: Column(
          children: [
            SizedBox(
              height: getValueForScreenType(
                context: context,
                mobile: 16,
                tablet: 25,
              ),
            ),
            Builder(
              builder: (final context) => TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: translate(context, TranslationKeys.General_Search),
                ),
                onChanged: ExhibitorsBloc.of(context).updateSearch,
              ),
            ),
            Expanded(
              child: ExhibitorsList(),
            ),
          ],
        ),
      ),
    );
  }
}
