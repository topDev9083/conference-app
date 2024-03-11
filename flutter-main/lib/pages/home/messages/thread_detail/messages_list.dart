import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../bloc/profile_bloc.dart';
import '../../../../core/colors.dart';
import '../../../../extensions/date_time.dart';
import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../models/data/message_data.dart';
import '../../../../models/enums/message_type.dart';
import '../../../../utils/color_utils.dart';
import '../../../../utils/url_lanuncher.dart';
import '../../../../widgets/avatar.dart';
import '../../../../widgets/elevated_button.dart';
import '../../../../widgets/image.dart';
import '../../../../widgets/ink_well.dart';
import '../../../../widgets/time_zone_bloc_builder.dart';
import '../../../../widgets/trn_text.dart';
import '../../router/home_route_bloc.dart';
import '../../router/home_route_config.dart';
import '../../schedule_meetings/router/schedule_meetings_route_config.dart';
import 'bloc/thread_detail_bloc.dart';
import 'bloc/thread_detail_state.dart';

class MessagesList extends StatelessWidget {
  const MessagesList();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ThreadDetailBloc, ThreadDetailState>(
      builder: (final _, final state) {
        final messages = state.messagesApi.data!;
        return Scrollbar(
          child: ListView.builder(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: getValueForScreenType(
                context: context,
                mobile: 20,
                tablet: 46,
              ),
              vertical: 30,
            ),
            itemBuilder: (final _, final index) => _EachThread(
              messages[index],
              nextMessage:
                  index == messages.length - 1 ? null : messages[index + 1],
              prevMessage: index == 0 ? null : messages[index - 1],
            ),
            itemCount: messages.length,
          ),
        );
      },
    );
  }
}

class _EachThread extends StatelessWidget {
  final MessageData message;
  final MessageData? nextMessage;
  final MessageData? prevMessage;

  const _EachThread(
    this.message, {
    this.nextMessage,
    this.prevMessage,
  });

  @override
  Widget build(final BuildContext context) {
    final profile = ProfileBloc.of(context).state!;
    final user = ThreadDetailBloc.of(context).state.userApi.data!;

    final isSent = message.fromUserId == profile.id;
    final messageDT = message.createdOn.toDateTimeOnly();
    final nextMessageDT = nextMessage?.createdOn.toDateTimeOnly();
    final prevMessageDT = prevMessage?.createdOn.toDateTimeOnly();
    final hideAvatar = messageDT == nextMessageDT &&
        nextMessage?.fromUserId == message.fromUserId;
    final hideDateTime = messageDT == prevMessageDT &&
        prevMessage?.fromUserId == message.fromUserId;

    final avatar = hideAvatar
        ? const SizedBox(
            width: 33,
            height: 33,
          )
        : UserAvatar(
            profilePicture:
                isSent ? profile.profilePicture : user.profilePicture,
            size: 33,
          );
    final bubble = Expanded(
      child: Column(
        crossAxisAlignment:
            isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: hideAvatar ? 4 : 0,
            ),
            child: _Bubble(
              message,
              showDateTime: !hideDateTime,
            ),
          ),
        ],
      ),
    );
    return Padding(
      padding: EdgeInsets.only(
        top: hideAvatar ? 0 : 18,
      ),
      child: isSent
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                bubble,
                const SizedBox(width: 8),
                avatar,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatar,
                const SizedBox(width: 8),
                bubble,
              ],
            ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final MessageData message;
  final bool showDateTime;

  const _Bubble(
    this.message, {
    this.showDateTime = false,
  });

  @override
  Widget build(final BuildContext context) {
    final profileId = ProfileBloc.of(context).state!.id;
    final isSent = message.fromUserId == profileId;
    final userId = ThreadDetailBloc.of(context).state.userId;
    Widget child = const SizedBox();
    switch (message.type) {
      case MessageType.image:
        child = ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 200,
            maxHeight: 500,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: WCImage(
                  image: message.fileUrl!,
                ),
              ),
              Positioned.fill(
                child: WCInkWell(
                  isDark: true,
                  onTap: () => launchUrl(
                    message.fileUrl!,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case MessageType.meeting:
        child = Container(
          decoration: BoxDecoration(
            color: ColorUtils.lighten(
              Theme.of(context).primaryColor,
              0.9,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WCImage(
                    image: 'ic_schedule_meeting.png',
                    color: Theme.of(context).primaryColor,
                    width: 16,
                  ),
                  const SizedBox(width: 11),
                  const TrnText(
                    TranslationKeys.Messages_Meeting_Request,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                message.message!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: WCColors.grey_5d.withOpacity(0.92),
                ),
              ),
              const SizedBox(height: 20),
              WCElevatedButton(
                translate(
                  context,
                  TranslationKeys.Schedule_Meetings_User_Detail_View,
                )!,
                onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
                  HomeRouteConfig.scheduleMeetings(
                    scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(
                      selectedUserId: userId,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
        break;
      default:
        child = Container(
          decoration: BoxDecoration(
            color: isSent
                ? ColorUtils.darken(Theme.of(context).primaryColor)
                : ColorUtils.lighten(
                    Theme.of(context).primaryColor,
                    0.9,
                  ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: WCInkWell(
            isDark: isSent,
            padding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 7,
            ),
            borderRadius: BorderRadius.circular(10),
            onTap: message.fileUrl == null
                ? null
                : () => launchUrl(message.fileUrl!),
            child: message.fileUrl == null
                ? SelectableText(
                    message.message ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: isSent ? Colors.white : null,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_download_outlined,
                        color: isSent ? Colors.white : null,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          message.message ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            color: isSent ? Colors.white : null,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
    }
    return Column(
      crossAxisAlignment:
          isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        child,
        if (showDateTime) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TimeZoneBlocBuilder(
              builder: (final timeZone) => Text(
                message.createdOn.timeAgo(
                  timeZone: timeZone,
                ),
                style: TextStyle(
                  color: WCColors.black_09.withOpacity(0.5),
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
