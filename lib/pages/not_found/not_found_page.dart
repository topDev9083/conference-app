import 'package:flutter/material.dart';

import '../../bloc/profile_bloc.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../router/app_route_bloc.dart';
import '../../router/app_route_config.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/image.dart';

class NotFoundPage extends StatelessWidget {
  static const ROUTE_NAME = '/404';

  const NotFoundPage();

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: WCImage(
                image: 'page_not_found.png',
                width: 397,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              translate(context, TranslationKeys.Page_Not_Found_Title)!,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              translate(context, TranslationKeys.Page_Not_Found_Subtitle)!,
              style: const TextStyle(
                // fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            WCElevatedButton(
              translate(context, TranslationKeys.Page_Not_Found_Go_Back)!,
              onTap: () {
                final AppRouteConfig config;
                if (ProfileBloc.of(context).state == null) {
                  config = const AppRouteConfig.auth();
                } else {
                  config = const AppRouteConfig.home();
                }
                AppRouteBloc.of(context).updateRouteConfig(config);
              },
            ),
          ],
        ),
      ),
    );
  }
}
