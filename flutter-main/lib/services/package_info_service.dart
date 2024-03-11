import 'package:package_info_plus/package_info_plus.dart';

class _PackageInfoService {
  late PackageInfo _packageInfo;

  Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  String getIosApplicationId() {
    return _packageInfo.packageName;
  }

  String getAppName() {
    return _packageInfo.appName;
  }
}

final packageInfoService = _PackageInfoService();
