import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/event_bloc.dart';
import 'bloc/event_code_bloc.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/state/event_state.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'core/configs.dart';
import 'core/environment.dart';
import 'core/theme.dart';
import 'firebase_options.dart';
import 'flutter_i18n/translation_keys.dart';
import 'models/data/event_data.dart';
import 'router/app_route_bloc.dart';
import 'services/package_info_service.dart';
import 'services/shared_preferences_service.dart';
import 'services/timezone_service.dart';
import 'utils/logging_utils.dart';
import 'widgets/keyboard_remover.dart';

final _logger = Logger('main.dart');

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  timezoneService.initialize();
  LoggingUtils.initialize();
  // do it before Firebase.initializeApp
  await packageInfoService.initialize();
  await dotenv.load(
    fileName: 'config/${dartEnv.name}.config',
  );
  await Firebase.initializeApp(
    options: kIsWeb ? DefaultFirebaseOptions.web : null,
  );
  if (!kIsWeb && !kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  await sharedPreferencesService.initialize();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (final _) => EventCodeBloc(),
        ),
        BlocProvider(
          create: (final context) => EventBloc(
            eventCodeBloc: EventCodeBloc.of(context),
          ),
        ),
        BlocProvider(
          create: (final context) => ProfileBloc(
            eventBloc: EventBloc.of(context),
            eventCodeBloc: EventCodeBloc.of(context),
          ),
        ),
        BlocProvider(
          create: (final context) => AppRouteBloc(
            profileBloc: ProfileBloc.of(context),
          ),
        ),
      ],
      child: BlocSelector<EventBloc, EventState, EventData?>(
        selector: (final state) => state.getEventApi.data,
        builder: (final context, final event) {
          final appRouteState = AppRouteBloc.of(context).state;
          return KeyboardRemover(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (final context) =>
                  event?.name ?? translate(context, TranslationKeys.App_Name)!,
              theme: getTheme(event?.appConfig),
              localizationsDelegates: [
                FlutterI18nDelegate(
                  translationLoader: FileTranslationLoader(),
                  missingTranslationHandler: (final key, final locale) {
                    _logger.warning(
                      "--- Missing Key: $key, languageCode: ${locale?.languageCode}",
                    );
                  },
                ),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                Locale(config.defaultLanguageCode),
              ],
              routeInformationParser: appRouteState.routeInformationParser,
              routerDelegate: appRouteState.routerDelegate,
              backButtonDispatcher: appRouteState.backButtonDispatcher,
            ),
          );
        },
      ),
    );
  }
}
