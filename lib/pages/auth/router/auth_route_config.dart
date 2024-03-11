import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_route_config.freezed.dart';

@freezed
class AuthRouteConfig with _$AuthRouteConfig {
  const factory AuthRouteConfig.login() = _AuthRouteConfigLogin;

  const factory AuthRouteConfig.signup() = _AuthRouteConfigSignup;

  const factory AuthRouteConfig.forgotPassword() =
      _AuthRouteConfigForgotPassword;
}
