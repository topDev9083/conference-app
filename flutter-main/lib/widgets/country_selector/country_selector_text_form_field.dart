import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../models/data/country_data.dart';
import '../../utils/responsive_utils.dart';
import '../connection_information.dart';
import '../dropdown_container.dart';
import '../ink_well.dart';
import '../list_paginator.dart';
import '../search_text_form_field.dart';
import '../sheet_button.dart';
import '../trn_text.dart';
import 'bloc/country_selector_bloc.dart';
import 'bloc/country_selector_state.dart';

class CountrySelectorTextFormField extends StatefulWidget {
  final CountryData? selectedCountry;
  final ValueChanged<CountryData?>? onCountrySelected;
  final bool enabled;

  const CountrySelectorTextFormField({
    this.selectedCountry,
    this.onCountrySelected,
    this.enabled = true,
  });

  @override
  State<CountrySelectorTextFormField> createState() =>
      _CountrySelectorTextFormFieldState();
}

class _CountrySelectorTextFormFieldState
    extends State<CountrySelectorTextFormField> {
  late TextEditingController _countryController;

  @override
  void initState() {
    _countryController = TextEditingController(
      text: widget.selectedCountry?.name,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant final CountrySelectorTextFormField oldWidget) {
    if (widget.selectedCountry != oldWidget.selectedCountry) {
      Future.delayed(Duration.zero, () {
        _countryController.text = widget.selectedCountry?.name ?? '';
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) {
    return SheetButton(
      offset: 2,
      inkWellBorderRadius: 8,
      showButtonRipple: false,
      dropDownHeight: 250,
      enabled: widget.enabled,
      dropDownWidth: () {
        if (ScreenType.of(context).isMobile) {
          return null;
        } else {
          return 400.0;
        }
      }(),
      button: IgnorePointer(
        child: TextFormField(
          controller: _countryController,
          decoration: const InputDecoration(
            label: TrnText(
              TranslationKeys.Edit_Organization_Country,
            ),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
      dropdown: (final _) => BlocProvider(
        create: (final _) => CountrySelectorBloc(),
        child: _CountriesDropDown(
          onCountrySelected: widget.onCountrySelected,
        ),
      ),
    );
  }
}

class _CountriesDropDown extends StatelessWidget {
  final ValueChanged<CountryData?>? onCountrySelected;

  const _CountriesDropDown({
    required this.onCountrySelected,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<CountrySelectorBloc, CountrySelectorState>(
      builder: (final context, final state) => DropdownContainer(
        borderRadius: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SearchTextFormField(
                initialValue: state.searchText,
                onChanged: CountrySelectorBloc.of(context).updateSearchText,
              ),
            ),
            if (state.searchCountriesApi.data == null) ...[
              Expanded(
                child: Center(
                  child: ConnectionInformation(
                    error: state.searchCountriesApi.error,
                    onRetry: CountrySelectorBloc.of(context).searchCountries,
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemBuilder: (final context, final index) {
                    final list = state.searchCountriesApi.data!;
                    if (index >= list.length) {
                      return ListPaginator(
                        error: state.searchCountriesApi.error,
                        onLoad: () => CountrySelectorBloc.of(context)
                            .searchCountries(list.length),
                      );
                    }
                    final country = list[index];
                    return WCInkWell(
                      onTap: () {
                        onCountrySelected?.call(country);
                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Text(
                        country.name,
                        style: TextStyle(
                          color: WCColors.black_09.withOpacity(0.73),
                          fontSize: 13,
                        ),
                      ),
                    );
                  },
                  itemCount: state.searchCountriesApi.data!.length +
                      (state.searchCountriesApi.isApiPaginationEnabled ? 1 : 0),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
