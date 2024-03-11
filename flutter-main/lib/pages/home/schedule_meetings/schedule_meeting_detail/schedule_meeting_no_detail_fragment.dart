import 'package:flutter/material.dart';

import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../utils/responsive_utils.dart';
import '../../../../widgets/image.dart';

class ScheduleMeetingNoDetailFragment extends StatelessWidget {
  const ScheduleMeetingNoDetailFragment();

  @override
  Widget build(final BuildContext context) {
    if (ScreenType.of(context).isMobile) {
      return const SizedBox();
    } else {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: WCImage(
                image: 'schedule_meeting_select_user.png',
                width: 400,
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            Text(
              translate(
                context,
                TranslationKeys.Schedule_Meetings_Select_User,
              )!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }
}
