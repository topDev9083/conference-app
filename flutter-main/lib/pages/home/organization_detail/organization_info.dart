import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/close_icon.dart';
import '../../../widgets/image.dart';
import '../../../widgets/user_container.dart';
import 'bloc/organization_detail_bloc.dart';
import 'bloc/organization_detail_state.dart';

class OrganizationInfo extends StatelessWidget {
  const OrganizationInfo();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<OrganizationDetailBloc, OrganizationDetailState>(
      builder: (final _, final state) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: CloseIcon(
                onTap: () => Navigator.pop(context),
                bgColor: Colors.white,
              ),
            ),
            UserContainer(
              showShadow: true,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      UserAvatar(
                        size: 55,
                        profilePicture: state.organization.logo,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        state.organization.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (state.boothNumber != null) ...[
                    const SizedBox(height: 16),
                    _IconText(
                      icon: 'ic_calendar.png',
                      text: translate(
                        context,
                        TranslationKeys.Exhibitors_Booth_Number_Value,
                        translationParams: {
                          'value': state.boothNumber!,
                        },
                      )!,
                    ),
                  ],
                  if (state.organization.phoneNumber != null) ...[
                    const SizedBox(height: 16),
                    _IconText(
                      icon: 'ic_phone.png',
                      text: state.organization.phoneNumber!,
                    ),
                  ],
                  if (state.organization.website != null) ...[
                    const SizedBox(height: 16),
                    _IconText(
                      icon: 'ic_globe.png',
                      text: state.organization.website!,
                    ),
                  ],
                  if (state.organization.email != null) ...[
                    const SizedBox(height: 16),
                    _IconText(
                      icon: 'ic_mail.png',
                      text: state.organization.email!,
                    ),
                  ],
                  if (state.organization.address != null ||
                      state.organization.city != null ||
                      state.organization.state != null ||
                      state.organization.country != null) ...[
                    const SizedBox(height: 16),
                    _IconText(
                      icon: 'ic_pin.png',
                      text: [
                        state.organization.address,
                        state.organization.city,
                        state.organization.state,
                        state.organization.country?.name,
                      ].where((final item) => item != null).toList().join(', '),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (state.organization.profile != null) ...[
              const SizedBox(height: 30),
              Text(
                translate(context, TranslationKeys.Profile_Bio)!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.organization.profile!,
                style: TextStyle(
                  fontSize: 13,
                  color: WCColors.black_09.withOpacity(0.5),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final String icon;
  final String text;

  const _IconText({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        WCImage(
          image: icon,
          width: 12,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: WCColors.black_09.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
