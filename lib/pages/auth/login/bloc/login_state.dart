import 'package:built_value/built_value.dart';

import '../../../../models/data/user_data.dart';
import '../../../../models/states/api_state.dart';

part 'login_state.g.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  factory LoginState([final void Function(LoginStateBuilder) updates]) =
      _$LoginState;

  LoginState._();

  static void _initializeBuilder(final LoginStateBuilder b) => b
    ..email = ''
    ..password = '';

  String get email;

  String get password;

  String? get emailError;

  String? get passwordError;

  ApiState<UserData> get api;
}
