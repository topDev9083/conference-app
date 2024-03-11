import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScreenType {
  static ScreenTypeInformation of(final BuildContext context) {
    final deviceScreenType = getDeviceType(MediaQuery.of(context).size);
    return ScreenTypeInformation(deviceScreenType);
  }
}

class ScreenTypeInformation {
  final DeviceScreenType deviceScreenType;

  ScreenTypeInformation(this.deviceScreenType);

  // watch
  bool get isWatch => deviceScreenType == DeviceScreenType.watch;

  // mobile
  bool get isMobile => deviceScreenType == DeviceScreenType.mobile;

  bool get isMobileOrTablet => isMobile || isTablet;

  // table
  bool get isTablet => deviceScreenType == DeviceScreenType.tablet;

  bool get isTabletOrGreater => isTablet || isDesktop;

  // desktop
  bool get isDesktop => deviceScreenType == DeviceScreenType.desktop;
}
