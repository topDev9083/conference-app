import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/state/event_state.dart';
import '../../widgets/connection_information.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (final _, final eventState) => Scaffold(
        body: Center(
          child: ConnectionInformation(
            error: eventState.getEventApi.error,
            onRetry: EventBloc.of(context).getEvent,
          ),
        ),
      ),
    );
  }
}
