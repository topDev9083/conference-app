import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../flutter_i18n/translation_keys.dart';
import '../models/states/api_state.dart';
import 'dialogs.dart';

class PopBlocListener<B extends BlocBase<S>, S> extends BlocListener<B, S> {
  PopBlocListener({
    required final Object? Function(S state) when,
    final Widget? child,
  }) : super(
          listener: (final context, final _) => Navigator.pop(context),
          listenWhen: (final prev, final next) =>
              when(prev) == null && when(next) != null,
          child: child,
        );
}

class ErrorBlocListener<B extends BlocBase<S>, S> extends BlocListener<B, S> {
  ErrorBlocListener({
    required final String? Function(S state) errorWhen,
    final Widget? child,
  }) : super(
          listener: (final context, final state) => WCDialog.showError(
            context,
            subtitle: translate(context, errorWhen(state)),
          ),
          listenWhen: (final prev, final next) =>
              errorWhen(prev) == null && errorWhen(next) != null,
          child: child,
        );
}

class ActionBlocListener<B extends BlocBase<S>, S> extends BlocListener<B, S> {
  ActionBlocListener({
    required final Object? Function(S state) when,
    required final BlocWidgetListener<S> listener,
    final Widget? child,
  }) : super(
          listener: listener,
          listenWhen: (final prev, final next) =>
              when(prev) == null && when(next) != null,
          child: child,
        );
}

class ErrorsMapBlocListener<B extends BlocBase<S>, S, Key, ApiStateData>
    extends BlocListener<B, S> {
  ErrorsMapBlocListener({
    required final BuildContext context,
    required final BuiltMap<Key, ApiState<ApiStateData>> Function(S state)
        errorWhen,
    final Widget? child,
  }) : super(
          listenWhen: (final prev, final next) {
            final prevMap = errorWhen(prev);
            final nextMap = errorWhen(next);
            for (final nextKey in nextMap.keys) {
              if (nextMap[nextKey]!.error != null &&
                  prevMap[nextKey]?.error == null) {
                WCDialog.showError(
                  context,
                  subtitle: translate(context, nextMap[nextKey]!.error),
                );
                break;
              }
            }
            return false;
          },
          listener: (final context, final state) {},
          child: child,
        );
}
