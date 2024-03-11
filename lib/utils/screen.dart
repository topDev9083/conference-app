import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Screen extends Page {
  final bool staticAnimation;

  const Screen({
    final LocalKey? key,
    this.staticAnimation = false,
  }) : super(key: key);

  @override
  Route createRoute(final BuildContext context) {
    if (kIsWeb || staticAnimation) {
      return NoAnimationPageRoute(
        settings: this,
        builder: (final _) => createChild(context),
      );
    } else {
      return MaterialPageRoute(
        settings: this,
        builder: (final _) => createChild(context),
      );
    }
  }

  Widget createChild(final BuildContext context);
}

class AdaptiveRoute {
  final RouteSettings? settings;
  final WidgetBuilder builder;

  AdaptiveRoute({
    required this.settings,
    required this.builder,
  });
}

class NoAnimationPageRoute extends PageRouteBuilder {
  NoAnimationPageRoute({
    required final WidgetBuilder builder,
    final RouteSettings? settings,
  }) : super(
          settings: settings,
          pageBuilder: (final context, final _, final __) => builder(context),
          transitionDuration: Duration.zero,
        );
}
