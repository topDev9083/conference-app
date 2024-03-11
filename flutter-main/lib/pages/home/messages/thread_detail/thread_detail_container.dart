import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/colors.dart';
import '../../../../widgets/avatar.dart';
import '../../../../widgets/close_icon.dart';
import '../../../../widgets/connection_information.dart';
import '../../../../widgets/ink_well.dart';
import '../../router/home_route_bloc.dart';
import '../../router/home_route_config.dart';
import '../../schedule_meetings/router/schedule_meetings_route_config.dart';
import '../router/messages_route_bloc.dart';
import 'bloc/thread_detail_bloc.dart';
import 'bloc/thread_detail_state.dart';
import 'messages_list.dart';
import 'send_message_field.dart';

class ThreadDetailContainer extends StatelessWidget {
  const ThreadDetailContainer();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ThreadDetailBloc, ThreadDetailState>(
      builder: (final _, final state) =>
          state.userApi.data == null || state.messagesApi.data == null
              ? Center(
                  child: ConnectionInformation(
                    error: state.userApi.error ?? state.messagesApi.error,
                    onRetry: () {
                      if (state.userApi.error != null) {
                        ThreadDetailBloc.of(context).getUser();
                      }
                      if (state.messagesApi.error != null) {
                        ThreadDetailBloc.of(context).getMessages();
                      }
                    },
                  ),
                )
              : const Column(
                  children: [
                    SizedBox(height: 20),
                    _UserInfo(),
                    Expanded(
                      child: MessagesList(),
                    ),
                    SendMessageField(),
                    SizedBox(height: 20),
                  ],
                ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ThreadDetailBloc, ThreadDetailState>(
      builder: (final _, final state) {
        final user = state.userApi.data!;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getValueForScreenType(
              context: context,
              mobile: 16,
              tablet: 30,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: WCInkWell(
                    onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
                      HomeRouteConfig.scheduleMeetings(
                        scheduleMeetingsRouteConfig:
                            ScheduleMeetingsRouteConfig(
                          selectedUserId: user.id,
                        ),
                      ),
                    ),
                    isOverLay: true,
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(9),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UserAvatar(
                          profilePicture: user.profilePicture,
                          size: 47,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              user.fullName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (user.jobAtOrganization != null) ...[
                              Text(
                                user.jobAtOrganization!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: WCColors.black_09.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CloseIcon(
                onTap: () => MessagesRouteBloc.of(context).updateSelectedUserId(
                  null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
