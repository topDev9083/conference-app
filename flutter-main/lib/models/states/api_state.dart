import 'package:built_value/built_value.dart';

part 'api_state.g.dart';

abstract class ApiState<T> implements Built<ApiState<T>, ApiStateBuilder<T>> {
  factory ApiState([final void Function(ApiStateBuilder<T>) updates]) =
      _$ApiState<T>;

  ApiState._();

  static void _initializeBuilder<T>(final ApiStateBuilder<T> b) => b
    ..isApiInProgress = false
    ..isApiPaginationEnabled = false;

  bool get isApiInProgress;

  bool get isApiPaginationEnabled;

  String? get error;

  String? get message;

  T? get data;
}
