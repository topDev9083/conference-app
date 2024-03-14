import 'package:freezed_annotation/freezed_annotation.dart';

part 'lead_scanner_route_config.freezed.dart';

@freezed
class LeadScannerRouteConfig with _$LeadScannerRouteConfig {
  const factory LeadScannerRouteConfig({
    final int? selectedUserId,
  }) = _LeadScannerRouteConfig;
}
