import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../widgets/image.dart';

class ThreadNoDetailFragment extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (final _) => const SizedBox(),
      tablet: (final _) => Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: WCImage(
                image: 'message_select_user.png',
                width: 400,
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            Text(
              translate(context, TranslationKeys.Messages_Select_User)!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
