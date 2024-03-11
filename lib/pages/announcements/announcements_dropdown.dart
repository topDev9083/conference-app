import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/connection_information.dart';
import '../../widgets/dropdown_container.dart';
import 'announcements_list.dart';
import 'bloc/announcements_bloc.dart';
import 'bloc/announcements_state.dart';

class AnnouncementsDropdown extends StatelessWidget {
  final AnnouncementsBloc bloc;

  const AnnouncementsDropdown({
    required this.bloc,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<AnnouncementsBloc, AnnouncementsState>(
        builder: (final context, final state) => DropdownContainer(
          borderRadius: 5,
          height: 312,
          child: state.getAnnouncementsApi.data == null
              ? Center(
                  child: ConnectionInformation(
                    error: state.getAnnouncementsApi.error,
                    onRetry: AnnouncementsBloc.of(context).getAnnouncements,
                  ),
                )
              : const AnnouncementsList(),
        ),
      ),
    );
  }
}
