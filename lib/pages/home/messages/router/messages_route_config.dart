import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_route_config.freezed.dart';

@freezed
class MessagesRouteConfig with _$MessagesRouteConfig {
  const factory MessagesRouteConfig({
    final int? selectedUserId,
  }) = _MessagesRouteConfig;
}
