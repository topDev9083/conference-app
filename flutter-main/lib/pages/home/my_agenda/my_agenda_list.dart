import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../extensions/date_time.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/agenda_combined_data.dart';
import '../../../models/enums/agenda_combined_type.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/time_zone_bloc_builder.dart';
import '../../add_user_occupancy/add_user_occupancy_dialog.dart';
import 'bloc/my_agenda_bloc.dart';
import 'bloc/my_agenda_state.dart';
import 'meeting_item.dart';
import 'occupancy_item.dart';
import 'session_item.dart';

class MyAgendaList extends StatelessWidget {
  const MyAgendaList();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MyAgendaBloc, MyAgendaState>(
      builder: (final _, final state) => state.getAgendaApi.data == null
          ? Center(
              child: ConnectionInformation(
                onRetry: MyAgendaBloc.of(context).getMyAgenda,
                error: state.getAgendaApi.error,
              ),
            )
          : TimeZoneBlocBuilder(
              builder: (final timeZone) => ListView.builder(
                itemBuilder: (final _, final index) => _MyAgendaItem(
                  state.combinedAgendas![index],
                  showHeader: index == 0 ||
                      !state.combinedAgendas![index].date.isAtSameDateAs(
                        state.combinedAgendas![index - 1].date,
                      ),
                ),
                itemCount: state.combinedAgendas!.length,
              ),
            ),
    );
  }
}

class _HeaderDivider extends StatelessWidget {
  final String text;
  final DateTime date;

  const _HeaderDivider({
    required this.text,
    required this.date,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: WCColors.grey_f1,
      padding: const EdgeInsets.symmetric(
        horizontal: 27,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          WCInkWell(
            padding: const EdgeInsets.all(8),
            onTap: () => _addUserOccupancy(context, date),
            child: Text(
              'Add Custom Agenda',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addUserOccupancy(
    final BuildContext context,
    final DateTime date,
  ) async {
    final bloc = MyAgendaBloc.of(context);
    final userOccupancy = await AddUserOccupancyDialog.show(
      context,
      date: date,
    );
    if (userOccupancy == null) {
      return;
    }
    bloc.addUserOccupancy(userOccupancy);
  }
}

class _MyAgendaItem extends StatelessWidget {
  final AgendaCombinedData agenda;
  final bool showHeader;

  const _MyAgendaItem(
    this.agenda, {
    this.showHeader = true,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showHeader) ...[
          TimeZoneBlocBuilder(
            builder: (final timeZone) => _HeaderDivider(
              text: agenda.date.format(
                format: DATE_FORMAT,
                timeZone: timeZone,
              ),
              date: agenda.date,
            ),
          ),
        ],
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(
            bottom: 2,
          ),
          child: () {
            switch (agenda.type) {
              case AgendaCombinedType.meeting:
                return MeetingItem(agenda.meeting!);
              case AgendaCombinedType.session:
                return SessionItem(agenda.session!);
              case AgendaCombinedType.occupancy:
                return OccupancyItem(agenda.occupancy!);
              default:
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 27,
                  ),
                  child: Text(
                    translate(context, TranslationKeys.My_Agenda_No_Agenda)!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                );
            }
          }(),
        ),
      ],
    );
  }
}
