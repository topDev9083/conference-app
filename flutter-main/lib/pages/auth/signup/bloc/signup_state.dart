import 'package:built_value/built_value.dart';

import '../../../../models/states/api_state.dart';

part 'signup_state.g.dart';

abstract class SignupState implements Built<SignupState, SignupStateBuilder> {
  factory SignupState([final void Function(SignupStateBuilder) updates]) =
      _$SignupState;

  SignupState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final SignupStateBuilder b) => b
    ..fullName = ''
    ..email = ''
    ..password = '';

  @BuiltValueHook(finalizeBuilder: true)
  static void _finalize(final SignupStateBuilder b) => b;

  String get fullName;

  String get email;

  String get password;

  ApiState<void> get signupApi;
}
