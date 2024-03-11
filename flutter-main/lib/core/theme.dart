import 'package:flutter/material.dart';

import '../models/data/app_config_data.dart';
import 'colors.dart';

ThemeData getTheme(final AppConfigData? appConfig) {
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: WCColors.grey_dc,
    ),
  );
  final primaryColor = appConfig?.primaryColor ?? WCColors.blue_21;
  return ThemeData(
    fontFamily: 'Inter',
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: primaryColor,
    ),
    scaffoldBackgroundColor: WCColors.grey_f7,
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 2,
      fillColor: Colors.white,
      filled: true,
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: inputBorder,
      disabledBorder: inputBorder,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all(
          primaryColor.withOpacity(0.38),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 50,
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 11,
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: primaryColor,
          ),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: WCColors.black_09.withOpacity(0.93),
      ),
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      space: 1,
      color: WCColors.grey_69.withOpacity(0.1),
    ),
    iconTheme: const IconThemeData(
      color: WCColors.black_09,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
    ),
  );
}
