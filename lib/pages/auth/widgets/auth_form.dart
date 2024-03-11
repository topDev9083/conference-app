import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/event_bloc.dart';
import '../../../bloc/state/event_state.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/app_config_data.dart';
import '../../../utils/responsive_utils.dart';
import '../../../widgets/image.dart';

class AuthForm extends StatelessWidget {
  final String titleKey;
  final List<InlineSpan> subtitle;
  final Widget child;

  const AuthForm({
    required this.titleKey,
    required this.child,
    this.subtitle = const [],
  });

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<EventBloc, EventState, AppConfigData?>(
      selector: (final state) => state.getEventApi.data?.appConfig,
      builder: (final _, final appConfig) {
        final isMobile = ScreenType.of(context).isMobile;
        final listView = ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: !isMobile,
          padding: EdgeInsets.symmetric(
            horizontal: getValueForScreenType(
              context: context,
              mobile: 16,
              tablet: 32,
              desktop: 64,
            ),
          ),
          children: [
            const SizedBox(height: 64),
            if (appConfig?.eventLogo != null) ...[
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: WCImage(
                  image: appConfig?.eventLogo!,
                  height: 80,
                ),
              ),
              const SizedBox(height: 32),
            ],
            Text(
              translate(context, titleKey)!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle.isNotEmpty) ...[
              DefaultTextStyle(
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                child: Builder(
                  builder: (final context) => RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: subtitle,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 47),
            child,
            const SizedBox(height: 32),
          ],
        );
        if (isMobile) {
          return listView;
        }
        return Center(
          child: listView,
        );
      },
    );
  }
}
