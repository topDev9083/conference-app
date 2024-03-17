import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/user_data.dart';
import '../../../models/enums/sort_by.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/dropdown_container.dart';
import '../../../widgets/focus_controller.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/list_paginator.dart';
import '../../../widgets/sheet_button.dart';
import '../../../widgets/text_field_controller.dart';
import '../../../widgets/user_item.dart';
import 'bloc/schedule_meetings_bloc.dart';
import 'bloc/schedule_meetings_state.dart';
import 'router/schedule_meetings_route_bloc.dart';

class UsersPanel extends StatelessWidget {
  const UsersPanel({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingsBloc.of(context);
    return BlocBuilder<ScheduleMeetingsBloc, ScheduleMeetingsState>(
      builder: (final _, final state) => Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const _SortByButton(),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: _SearchField(),
            ),
            Expanded(
              child: state.attendeesApi.data == null
                  ? Center(
                      child: ConnectionInformation(
                        error: state.attendeesApi.error,
                        onRetry: bloc.searchUsers,
                      ),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (final _, final index) {
                          final list = state.attendeesApi.data!;
                          if (index >= list.length) {
                            return ListPaginator(
                              error: state.attendeesApi.error,
                              onLoad: () => bloc.searchUsers(list.length),
                            );
                          } else {
                            return UserItem(
                              list[index],
                              showOnlineStatus: true,
                              onTap: () => _onUserSelected(
                                context,
                                list[index],
                              ),
                            );
                          }
                        },
                        itemCount: state.attendeesApi.data!.length +
                            (state.attendeesApi.isApiPaginationEnabled ? 1 : 0),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _onUserSelected(final BuildContext context, final UserData user) {
    ScheduleMeetingsRouteBloc.of(context).updateSelectedUserId(user.id);
  }
}

class _SortByButton extends StatelessWidget {
  const _SortByButton();

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingsBloc.of(context);
    return BlocBuilder<ScheduleMeetingsBloc, ScheduleMeetingsState>(
      buildWhen: (final prev, final next) =>
          prev.attendeesSortBy != next.attendeesSortBy,
      builder: (final _, final state) => SheetButton(
        button: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate(
                  context,
                  TranslationKeys.Schedule_Meetings_Users_Panel_Sort_By,
                  translationParams: {
                    'sortType': translate(
                      context,
                      () {
                        switch (state.attendeesSortBy) {
                          case SortBy.namee:
                            return TranslationKeys
                                .Schedule_Meetings_Users_Panel_Name;
                          case SortBy.jobTitle:
                            return TranslationKeys
                                .Schedule_Meetings_Users_Panel_Job_Title;
                          case SortBy.organizationName:
                            return TranslationKeys
                                .Schedule_Meetings_Users_Panel_Organization;
                          case SortBy.createdOn:
                            return TranslationKeys
                                .Schedule_Meetings_Users_Panel_Date_Added;
                          default:
                            return '';
                        }
                      }(),
                    )!,
                  },
                )!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const WCImage(
                image: 'ic_sort.png',
                width: 17,
              ),
            ],
          ),
        ),
        dropdown: (final context) => DropdownContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getSortByItem(
                context: context,
                titleKey: TranslationKeys.Schedule_Meetings_Users_Panel_Name,
                sortBy: SortBy.namee,
                bloc: bloc,
              ),
              getSortByItem(
                context: context,
                titleKey:
                    TranslationKeys.Schedule_Meetings_Users_Panel_Job_Title,
                sortBy: SortBy.jobTitle,
                bloc: bloc,
              ),
              getSortByItem(
                context: context,
                titleKey:
                    TranslationKeys.Schedule_Meetings_Users_Panel_Organization,
                sortBy: SortBy.organizationName,
                bloc: bloc,
              ),
              getSortByItem(
                context: context,
                titleKey:
                    TranslationKeys.Schedule_Meetings_Users_Panel_Date_Added,
                sortBy: SortBy.createdOn,
                bloc: bloc,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSortByItem({
    required final BuildContext context,
    required final String titleKey,
    required final SortBy sortBy,
    required final ScheduleMeetingsBloc bloc,
  }) {
    return WCInkWell(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 10,
      ),
      onTap: () {
        bloc.updateAttendeesSortBy(sortBy);
        Navigator.pop(context);
      },
      child: Text(
        translate(context, titleKey)!,
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingsBloc.of(context);
    return BlocBuilder<ScheduleMeetingsBloc, ScheduleMeetingsState>(
      buildWhen: (final prev, final next) =>
          prev.attendeesSearch.isEmpty != next.attendeesSearch.isEmpty,
      builder: (final _, final state) => TextFieldController(
        builder: (final controller) => FocusController(
          builder: (final focusNode) => Stack(
            children: [
              TextField(
                focusNode: focusNode,
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: translate(context, TranslationKeys.General_Search),
                ),
                onChanged: bloc.updateAttendeesSearch,
              ),
              if (state.attendeesSearch.isNotEmpty) ...[
                Positioned.fill(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                      onPressed: () {
                        bloc.updateAttendeesSearch('');
                        controller.clear();
                      },
                      icon: const Icon(Icons.close),
                    ),
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
