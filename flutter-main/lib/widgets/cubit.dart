import 'package:bloc/bloc.dart';
import 'package:built_value/built_value.dart';
import 'package:logging/logging.dart';

final _logger = Logger('cubit.dart');

abstract class WCCubit<State> extends Cubit<State> {
  WCCubit(final State initialState) : super(initialState);

  @override
  void emit(final State state) {
    try {
      super.emit(state);
    } catch (e) {
      _logger.warning(e.toString());
    }
  }
}

abstract class BVCubit<V extends Built<V, B>, B extends Builder<V, B>>
    extends WCCubit<V> {
  BVCubit(final V initialState) : super(initialState);
}
