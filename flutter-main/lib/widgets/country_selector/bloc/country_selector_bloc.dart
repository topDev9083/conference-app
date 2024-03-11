import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../models/data/country_data.dart';
import '../../../models/params/pagination_param.dart';
import '../../../models/response/api_response.dart';
import '../../../services/country_service.dart';
import '../../../utils/dio.dart';
import '../../cubit.dart';
import 'country_selector_state.dart';

class CountrySelectorBloc extends WCCubit<CountrySelectorState> {
  CancelToken? _searchCountriesCT;

  CountrySelectorBloc() : super(CountrySelectorState()) {
    searchCountries();
  }

  @override
  Future<void> close() {
    cancelDioToken(_searchCountriesCT);
    return super.close();
  }

  factory CountrySelectorBloc.of(final BuildContext context) =>
      BlocProvider.of<CountrySelectorBloc>(context);

  void updateSearchText(final String search) {
    emit(state.rebuild((final b) => b.searchText = search));
    searchCountries();
  }

  Future<void> searchCountries([final int offset = 0]) async {
    if (!state.searchCountriesApi.isApiPaginationEnabled && offset != 0) {
      return;
    }
    cancelDioToken(_searchCountriesCT);
    emit(
      state.rebuild(
        (final b) {
          b
            ..searchCountriesApi.isApiInProgress = true
            ..searchCountriesApi.error = null
            ..searchCountriesApi.isApiPaginationEnabled = true;
          if (offset == 0) {
            b.searchCountriesApi.data = null;
          }
        },
      ),
    );

    try {
      _searchCountriesCT = CancelToken();
      final countries = await countryService.searchCountries(
        search: state.searchText,
        pagination: PaginationParam(offset: offset),
        cancelToken: _searchCountriesCT,
        showUsersCount: true,
      );
      final ListBuilder<CountryData> allCountries = ListBuilder();
      if (offset != 0) {
        allCountries.addAll(state.searchCountriesApi.data!);
      }
      allCountries.addAll(countries);
      emit(
        state.rebuild(
          (final b) => b
            ..searchCountriesApi.data = allCountries.build()
            ..searchCountriesApi.isApiPaginationEnabled =
                countries.length >= RECORDS_LIMIT,
        ),
      );
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild(
            (final b) => b.searchCountriesApi.error = metaData.message,
          ),
        );
      }
    }
    emit(
      state.rebuild((final b) => b.searchCountriesApi.isApiInProgress = false),
    );
  }
}
