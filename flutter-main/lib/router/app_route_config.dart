import 'package:freezed_annotation/freezed_annotation.dart';

import '../pages/auth/router/auth_route_config.dart';
import '../pages/home/router/home_route_config.dart';

part 'app_route_config.freezed.dart';

@freezed
class AppRouteConfig with _$AppRouteConfig {
  const factory AppRouteConfig.auth({
    @Default(AuthRouteConfig.login()) final AuthRouteConfig authRouteConfig,
  }) = _AppRouteConfigAuth;

  const factory AppRouteConfig.home({
    @Default(HomeRouteConfig.dashboard()) final HomeRouteConfig homeRouteConfig,
  }) = _AppRouteConfigHome;
}
