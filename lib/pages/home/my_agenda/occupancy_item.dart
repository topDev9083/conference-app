import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/user_occupancy_data.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/progress_indicator.dart';
import 'bloc/my_agenda_bloc.dart';
import 'time.dart';

class OccupancyItem extends StatelessWidget {
  final UserOccupancyData occupancy;

  const OccupancyItem(this.occupancy);

  @override
  Widget build(final BuildContext context) {
    final bloc = MyAgendaBloc.of(context);
    final apiState =
        bloc.state.deleteUserOccupancies[occupancy.id] ?? ApiState<void>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, 7.5),
            child: Time(
              start: occupancy.startDate,
              end: occupancy.endDate,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      translate(
                        context,
                        TranslationKeys.My_Agenda_Unavailable,
                      )!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 17),
                    if (apiState.isApiInProgress) ...[
                      WCProgressIndicator.small(),
                    ] else ...[
                      WCInkWell(
                        padding: const EdgeInsets.all(8),
                        onTap: () => MyAgendaBloc.of(context)
                            .deleteUserOccupancy(occupancy.id),
                        borderRadius: BorderRadius.circular(999),
                        child: const WCImage(
                          image: 'ic_delete.png',
                          color: WCColors.red_ff,
                          height: 18,
                        ),
                      ),
                    ],
                  ],
                ),
                if (occupancy.reason != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    occupancy.reason!,
                    style: TextStyle(
                      color: WCColors.black_09.withOpacity(0.93),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
