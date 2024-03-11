import 'package:built_value/built_value.dart';

import '../../../models/states/api_state.dart';

part 'change_password_state.g.dart';

abstract class ChangePasswordState
    implements Built<ChangePasswordState, ChangePasswordStateBuilder> {
  factory ChangePasswordState([
    final void Function(ChangePasswordStateBuilder) updates,
  ]) = _$ChangePasswordState;

  ChangePasswordState._();

  static void _initializeBuilder(final ChangePasswordStateBuilder b) => b
    ..currentPassword = ''
    ..newPassword = ''
    ..confirmPassword = '';

  String get currentPassword;

  String get newPassword;

  String get confirmPassword;

  ApiState<void> get changePasswordApi;
}
