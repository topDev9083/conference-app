import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/cubit.dart';

typedef BlocListenerType<S> = void Function(S state);

class BlocBasicListener<C extends WCCubit<S>, S> {
  final Cubit<S> cubit;
  final BlocListenerCondition<S> listenWhen;

  late S lastState;

  BlocBasicListener({
    required this.cubit,
    required this.listenWhen,
  });

  StreamSubscription<S> listen(final BlocListenerType<S> listener) {
    lastState = cubit.state;
    return cubit.stream.listen((final state) {
      if (listenWhen(lastState, state)) {
        listener(state);
      }
      lastState = state;
    });
  }
}
