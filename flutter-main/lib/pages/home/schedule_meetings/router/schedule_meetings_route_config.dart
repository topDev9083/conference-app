import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_meetings_route_config.freezed.dart';

@freezed
class ScheduleMeetingsRouteConfig with _$ScheduleMeetingsRouteConfig {
  const factory ScheduleMeetingsRouteConfig({
    final int? selectedUserId,
  }) = _ScheduleMeetingsRouteConfig;
}
