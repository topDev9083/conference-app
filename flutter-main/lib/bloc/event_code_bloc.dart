import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';

import '../core/configs.dart';
import '../widgets/cubit.dart';

final _logger = Logger('event_code_bloc.dart');

class EventCodeBloc extends WCCubit<String?> with HydratedMixin {
  EventCodeBloc() : super(config.eventCode) {
    if (kIsWeb) {
      emit(_getWebSubdomain());
    }
  }

  factory EventCodeBloc.of(final BuildContext context) =>
      BlocProvider.of<EventCodeBloc>(context);

  void updateEventCode(final String eventCode) {
    emit(eventCode);
  }

  void resetEventCode() {
    if (kIsWeb) {
      emit(_getWebSubdomain());
    } else {
      emit(config.eventCode);
    }
  }

  String _getWebSubdomain() {
    final uri = Uri.base;
    final aDomain = uri.host.split('.');
    if (aDomain.length == 3) {
      return aDomain.first;
    }
    return 'google'; // when its on web and its localhost
  }

  @override
  String? fromJson(final Map<String, dynamic> json) {
    try {
      if (kIsWeb) {
        return _getWebSubdomain();
      }
      if (json.containsKey('eventCode')) {
        return json['eventCode'];
      }
    } catch (e) {
      _logger.severe('fromJson: $e');
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson(final String? state) {
    if (state != null) {
      return {
        'eventCode': state,
      };
    }
    return {};
  }
}
