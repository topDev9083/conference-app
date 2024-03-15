import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../extensions/date_time.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/user_data.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/counter.dart';
import '../../../widgets/focus_controller.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/list_paginator.dart';
import '../../../widgets/text_field_controller.dart';
import '../../../widgets/time_zone_bloc_builder.dart';
import '../../../widgets/user_online_dot.dart';
import 'bloc/messages_bloc.dart';
import 'bloc/messages_state.dart';
import 'router/messages_route_bloc.dart';

class UsersPanel extends StatelessWidget {
  const UsersPanel({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final bloc = MessagesBloc.of(context);
    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (final _, final state) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: _SearchField(),
            ),
            Expanded(
              child: state.usersApi.data == null
                  ? Center(
                      child: ConnectionInformation(
                        error: state.usersApi.error,
                        onRetry: MessagesBloc.of(context).searchUsers,
                      ),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                        itemBuilder: (final _, final index) {
                          final users = state.usersApi.data!;
                          if (index >= users.length) {
                            return ListPaginator(
                              error: state.usersApi.error,
                              onLoad: () => bloc.searchUsers(users.length),
                            );
                          } else {
                            return _UserItem(
                              users[index],
                              showHeader: index == 0 ||
                                  users[index].lastMessage == null &&
                                      users[index - 1].lastMessage != null,
                            );
                          }
                        },
                        itemCount: state.usersApi.data!.length +
                            (state.usersApi.isApiPaginationEnabled ? 1 : 0),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(final BuildContext context) {
    final bloc = MessagesBloc.of(context);
    return BlocBuilder<MessagesBloc, MessagesState>(
      buildWhen: (final prev, final next) =>
          prev.usersSearch.isNotEmpty != next.usersSearch.isNotEmpty,
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
                onChanged: bloc.updateSearch,
              ),
              if (state.usersSearch.isNotEmpty) ...[
                Positioned.fill(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                      onPressed: () {
                        bloc.updateSearch('');
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

class _UserItem extends StatelessWidget {
  final UserData user;
  final bool showDivider;
  final bool showHeader;

  const _UserItem(
    this.user, {
    // ignore: unused_element
    this.showDivider = true,
    this.showHeader = false,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader) ...[
          const SizedBox(height: 19),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              translate(
                context,
                user.lastMessage != null
                    ? TranslationKeys.Messages_Chats
                    : TranslationKeys.Messages_Contacts,
              )!,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        WCInkWell(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
          onTap: () {
            MessagesBloc.of(context).resetUnreadCount(user.id);
            MessagesRouteBloc.of(context).updateSelectedUserId(
              user.id,
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 22),
              Stack(
                children: [
                  UserAvatar(
                    profilePicture: user.profilePicture,
                    size: 47,
                  ),
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: UserOnlineDot(
                      isOnline: user.isOnline == true,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (user.lastMessageCreatedOn != null &&
                        user.lastMessage != null) ...[
                      TimeZoneBlocBuilder(
                        builder: (final timeZone) => Text(
                          user.lastMessageCreatedOn!.timeAgo(
                            timeZone: timeZone,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: WCColors.grey_7a,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        user.lastMessage!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: WCColors.grey_7a,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (user.unreadMessagesCount! > 0) ...[
                Counter(
                  count: user.unreadMessagesCount ?? 0,
                ),
              ] else ...[
                const SizedBox(width: 25),
              ],
              const SizedBox(width: 12),
            ],
          ),
        ),
        if (showDivider) ...[
          const Divider(),
        ],
      ],
    );
  }
}
