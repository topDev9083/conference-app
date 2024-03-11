import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/colors.dart';
import '../flutter_i18n/translation_keys.dart';
import '../models/data/organization_data.dart';
import '../pages/home/organization_detail/organization_detail_drawer.dart';
import '../utils/url_lanuncher.dart';
import 'avatar.dart';
import 'hover_text.dart';
import 'image.dart';
import 'static_grid.dart';
import 'user_container.dart';

class OrganizationItem extends StatelessWidget {
  final OrganizationData organization;
  final String? boothNumber;

  const OrganizationItem(
    this.organization, {
    this.boothNumber,
  });

  @override
  Widget build(final BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: getValueForScreenType(
          context: context,
          mobile: 0,
          tablet: 180,
        ),
      ),
      child: UserContainer(
        onTap: () => OrganizationDetailDrawer.open(
          context,
          organization: organization,
          boothNumber: boothNumber,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(
              profilePicture: organization.logo,
              size: 56,
            ),
            const SizedBox(width: 27),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    organization.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 13),
                  StaticGrid(
                    columns: 2,
                    runSpacing: 16,
                    children: [
                      _IconValue(
                        icon: 'ic_pin',
                        value: translate(
                          context,
                          TranslationKeys.Exhibitors_Location_Value,
                          translationParams: {
                            'value': organization.address ?? 'N/A',
                          },
                        )!,
                      ),
                      if (organization.email != null) ...[
                        _IconValue(
                          icon: 'ic_mail',
                          value: organization.email!,
                          onTap: () =>
                              launchUrl('mailto:${organization.email}'),
                        ),
                      ],
                      _IconValue(
                        icon: 'ic_calendar',
                        value: translate(
                          context,
                          TranslationKeys.Exhibitors_Booth_Number_Value,
                          translationParams: {
                            'value': boothNumber ?? 'N/A',
                          },
                        )!,
                      ),
                      _IconValue(
                        icon: 'ic_phone',
                        value: organization.phoneNumber ?? 'N/A',
                        onTap: organization.phoneNumber == null
                            ? null
                            : () =>
                                launchUrl('tel:${organization.phoneNumber}'),
                      ),
                      _IconValue(
                        icon: 'ic_globe',
                        value: organization.website ?? 'N/A',
                        onTap: organization.website == null
                            ? null
                            : () => launchUrl(organization.website!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconValue extends StatelessWidget {
  final String icon;
  final String value;
  final VoidCallback? onTap;

  const _IconValue({
    required this.icon,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        WCImage(
          image: '$icon.png',
          width: 14,
          color: WCColors.black_09.withOpacity(0.5),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: HoverText(
              value,
              active: onTap != null,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: WCColors.black_09.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
