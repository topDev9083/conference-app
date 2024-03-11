import 'package:built_value/built_value.dart';

import '../../../../models/states/api_state.dart';

part 'forgot_password_state.g.dart';

abstract class ForgotPasswordState
    implements Built<ForgotPasswordState, ForgotPasswordStateBuilder> {
  factory ForgotPasswordState([
    final void Function(ForgotPasswordStateBuilder) updates,
  ]) = _$ForgotPasswordState;

  ForgotPasswordState._();

  static void _initializeBuilder(final ForgotPasswordStateBuilder b) =>
      b..email = '';

  String get email;

  ApiState<void> get forgotPasswordApi;
}
