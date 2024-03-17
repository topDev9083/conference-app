import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tuple/tuple.dart';

import '../../../../core/colors.dart';
import '../../../../extensions/iterable.dart';
import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../models/enums/custom_field_type.dart';
import '../../../../utils/responsive_utils.dart';
import '../../../../widgets/avatar.dart';
import '../../../../widgets/close_icon.dart';
import '../../../../widgets/outlined_button.dart';
import '../../messages/router/messages_route_config.dart';
import '../../router/home_route_bloc.dart';
import '../../router/home_route_config.dart';
import 'bloc/schedule_meeting_detail_bloc.dart';
import 'bloc/schedule_meeting_detail_state.dart';
import 'colleagues.dart';
import 'meeting_organizer.dart';
import 'meeting_widgets/send_meeting_request_small_button.dart';
import 'notes.dart';

class UserDetail extends StatelessWidget {
  final VoidCallback? onClose;

  const UserDetail({
    this.onClose,
  });

  @override
  Widget build(final BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: CloseIcon(
            onTap: onClose,
          ),
        ),
        const _TopPanel(),
        const MeetingOrganizer(),
        const SizedBox(height: 29),
        const _OtherInformationPanel(),
        const SizedBox(height: 29),
        const Notes(),
        const SizedBox(height: 29),
        const Colleagues(),
      ],
    );
  }
}

class _TopPanel extends StatelessWidget {
  const _TopPanel();

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
        builder: (final _, final state) {
          final user = state.userApi.data!;
          return Column(
            children: [
              Row(
                children: [
                  UserAvatar(
                    profilePicture: user.profilePicture,
                    size: 56,
                  ),
                  const SizedBox(width: 19),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (user.jobAtOrganization != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            user.jobAtOrganization!,
                            style: TextStyle(
                              color: WCColors.black_09.withOpacity(0.5),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (SendMeetingRequestSmallButton.shouldVisible(
                            context,
                          ) &&
                          ScreenType.of(context).isDesktop) ...[
                        const SendMeetingRequestSmallButton(),
                        const SizedBox(width: 8),
                      ],
                      const _SendMessageButton(),
                    ],
                  ),
                ],
              ),
              if (SendMeetingRequestSmallButton.shouldVisible(context) &&
                  !ScreenType.of(context).isDesktop) ...[
                const SizedBox(height: 8),
                const SendMeetingRequestSmallButton(),
              ],
            ],
          );
        },
      );
}

class _SendMessageButton extends StatelessWidget {
  const _SendMessageButton();

  @override
  Widget build(final BuildContext context) {
    final userId = ScheduleMeetingDetailBloc.of(context).state.userId;
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) => WCOutlinedButton(
        title: getValueForScreenType(
          context: context,
          mobile: null,
          tablet: translate(
            context,
            TranslationKeys.Schedule_Meetings_User_Detail_Message,
          ),
        ),
        iconPng: 'ic_messages.png',
        onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
          HomeRouteConfig.messages(
            messagesRouteConfig: MessagesRouteConfig(
              selectedUserId: userId,
            ),
          ),
        ),
      ),
    );
  }
}

class _OtherInformationPanel extends StatelessWidget {
  const _OtherInformationPanel();

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingDetailBloc.of(context);
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) {
        final user = state.userApi.data!;

        final formattedCfValues = bloc.getFormattedCustomFieldValuesByTypes([
          CustomFieldType.radioGroup,
          CustomFieldType.textFieldString,
          CustomFieldType.textFieldNumber,
          CustomFieldType.checkboxSingle,
        ]);
        final checkboxGroupCfValues =
            bloc.getFormattedCustomFieldValuesByTypes([
          CustomFieldType.checkboxGroup,
        ]);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 37,
                runSpacing: 30,
                children: [
                  if (user.email != null) ...[
                    _TitleSubtitle(
                      titleKey:
                          TranslationKeys.Schedule_Meetings_User_Detail_Email,
                      value: user.email,
                    ),
                  ],
                  if (user.phoneNumber != null) ...[
                    _TitleSubtitle(
                      titleKey: TranslationKeys
                          .Schedule_Meetings_User_Detail_Phone_Number,
                      value: user.phoneNumber,
                    ),
                  ],
                  ...formattedCfValues!
                      .map((final cf) {
                        switch (cf.type) {
                          case CustomFieldType.checkboxSingle:
                            return cf.value == null
                                ? null
                                : Tuple2(
                                    cf.name,
                                    cf.value!.asBool ? 'Yes' : 'No',
                                  );
                          case CustomFieldType.textFieldNumber:
                          case CustomFieldType.textFieldString:
                            return cf.value == null
                                ? null
                                : Tuple2(cf.name, cf.value.toString());
                          case CustomFieldType.radioGroup:
                            final selectedChild = cf.children!.firstWhereOrNull(
                              (final child) => child.value?.asBool == true,
                            );
                            return selectedChild == null
                                ? null
                                : Tuple2(cf.name, selectedChild.name);
                          default:
                            return null;
                        }
                      })
                      .where((final tuple) => tuple != null)
                      .map(
                        (final tuple) => _TitleSubtitle(
                          title: tuple!.item1,
                          value: tuple.item2,
                        ),
                      ),
                  ...checkboxGroupCfValues!
                      .map(
                        (final cf) => Tuple2(
                          cf.name,
                          cf.children!
                              .where(
                                (final child) => child.value?.asBool == true,
                              )
                              .map((final child) => child.name)
                              .toList(),
                        ),
                      )
                      .where((final tuple) => tuple.item2.isNotEmpty)
                      .map(
                        (final tuple) => _TitleSubtitle(
                          title: tuple.item1,
                          values: tuple.item2,
                        ),
                      ),
                ],
              ),
            ),
            if (user.bio != null) ...[
              const SizedBox(height: 30),
              _TitleSubtitle(
                titleKey: TranslationKeys.Schedule_Meetings_User_Detail_Bio,
                value: user.bio,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _TitleSubtitle extends StatelessWidget {
  final String? titleKey;
  final String? title;
  final String? value;
  final List<String>? values;

  const _TitleSubtitle({
    this.titleKey,
    this.title,
    this.value,
    this.values,
  })  : assert(value != null || values != null),
        assert(titleKey != null || title != null);

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? translate(context, titleKey)!,
          style: TextStyle(
            fontSize: 13,
            color: WCColors.black_09.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 13),
        Wrap(
          spacing: 7,
          runSpacing: 3,
          children: (values ?? [value!])
              .map(
                (final v) => Container(
                  decoration: BoxDecoration(
                    color: WCColors.grey_f7,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(
                    v,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
