import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/tab_bar.dart';
import 'bloc/my_agenda_bloc.dart';
import 'bloc/my_agenda_state.dart';

class MyAgendaTabs extends StatelessWidget {
  const MyAgendaTabs();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MyAgendaBloc, MyAgendaState>(
      builder: (final _, final state) => EventTabBar(
        selectedDate: state.startDateTimeOfStartDate,
        onTabSelected: MyAgendaBloc.of(context).updateStartDate,
      ),
    );
  }
}
