import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/state/event_state.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../router/app_route_bloc.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/image.dart';
import 'router/auth_route_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage();

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<EventBloc, EventState, String?>(
      selector: (final state) => state.getEventApi.data?.appConfig.sponsorLogo,
      builder: (final _, final sponsorLogo) => BlocProvider(
        create: (final _) => AuthRouteBloc(
          appRouteBloc: AppRouteBloc.of(context),
        ),
        child: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 4,
                child: Builder(
                  builder: (final context) => Router(
                    key: GlobalObjectKey(this),
                    routerDelegate:
                        AuthRouteBloc.of(context).state.routerDelegate,
                  ),
                ),
              ),
              if (ScreenType.of(context).isTabletOrGreater) ...[
                Flexible(
                  flex: getValueForScreenType<int>(
                    context: context,
                    mobile: 0,
                    tablet: 3,
                    desktop: 4,
                  ),
                  child: Stack(
                    children: [
                      const WCImage(
                        image: 'auth_bg.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      if (sponsorLogo != null) ...[
                        Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: getValueForScreenType(
                                context: context,
                                mobile: 16,
                                tablet: 32,
                              ),
                              bottom: 32,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  translate(
                                    context,
                                    TranslationKeys
                                        .Auth_Login_Event_Sponsored_By,
                                  )!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getValueForScreenType(
                                      context: context,
                                      mobile: 49,
                                      desktop: 59,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 39),
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: WCImage(
                                    image: sponsorLogo,
                                    height: 80,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
