import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../models/data/country_data.dart';
import '../../../models/states/api_state.dart';

part 'country_selector_state.g.dart';

abstract class CountrySelectorState
    implements Built<CountrySelectorState, CountrySelectorStateBuilder> {
  factory CountrySelectorState([
    final void Function(CountrySelectorStateBuilder) updates,
  ]) = _$CountrySelectorState;

  CountrySelectorState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final CountrySelectorStateBuilder b) =>
      b..searchText = '';

  String get searchText;

  ApiState<BuiltList<CountryData>> get searchCountriesApi;
}
