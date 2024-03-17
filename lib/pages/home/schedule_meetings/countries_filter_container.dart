import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/checkbox_tile.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/list_paginator.dart';
import '../../../widgets/search_text_form_field.dart';
import 'bloc/schedule_meetings_bloc.dart';
import 'bloc/schedule_meetings_state.dart';

class CountriesFilterContainer extends StatelessWidget {
  final ScheduleMeetingsBloc bloc;

  const CountriesFilterContainer(this.bloc);

  @override
  Widget build(final BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ScheduleMeetingsBloc, ScheduleMeetingsState>(
        builder: (final _, final state) => Column(
          children: [
            const SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SearchTextFormField(
                initialValue: state.countriesSearch,
                onChanged: bloc.updateCountriesSearch,
              ),
            ),
            Expanded(
              child: state.countriesApi.data == null
                  ? Center(
                      child: ConnectionInformation(
                        error: state.countriesApi.error,
                        onRetry: bloc.searchCountries,
                      ),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                        itemBuilder: (final _, final index) {
                          final list = state.countriesApi.data!;
                          if (index >= list.length) {
                            return ListPaginator(
                              error: state.countriesApi.error,
                              onLoad: () => bloc.searchCountries(list.length),
                            );
                          }
                          final country = list[index];
                          return WCCheckboxTile(
                            title: country.name,
                            value:
                                state.selectedCountryIds.contains(country.id),
                            onChanged: (final isChecked) => isChecked
                                ? bloc.addCountryId(country.id)
                                : bloc.removeCountryId(country.id),
                          );
                        },
                        itemCount: state.countriesApi.data!.length +
                            (state.countriesApi.isApiPaginationEnabled ? 1 : 0),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
