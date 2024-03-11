import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/home_drawer_bloc.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../utils/responsive_utils.dart';
import '../../../widgets/bordered_row.dart';
import '../../../widgets/dropdown_container.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/sheet_button.dart';
import 'bloc/schedule_meetings_bloc.dart';
import 'countries_filter_container.dart';
import 'meeting_status_filter_container.dart';
import 'organizations_filter_container.dart';
import 'schedule_meetings_more_filters_drawer.dart';

class ScheduleMeetingsFilterPanel extends StatelessWidget {
  const ScheduleMeetingsFilterPanel();

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingsBloc.of(context);
    final child = Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 22),
      child: BorderedRow(
        isExpand: getValueForScreenType(
          context: context,
          mobile: false,
          tablet: true,
        ),
        children: [
          _FilterItem(
            titleKey:
                TranslationKeys.Schedule_Meetings_Filter_Panel_Organizations,
            filterContainer: OrganizationsFilterContainer(bloc),
          ),
          _FilterItem(
            titleKey: TranslationKeys.Schedule_Meetings_Filter_Panel_Countries,
            filterContainer: CountriesFilterContainer(bloc),
          ),
          _FilterItem(
            isSelfControlled: true,
            titleKey:
                TranslationKeys.Schedule_Meetings_Filter_Panel_Meeting_Status,
            filterContainer: MeetingStatusFilterContainer(bloc),
          ),
          _BlueButton(
            titleKey: TranslationKeys.Schedule_Meetings_Filter_Panel_More,
            onTap: () {
              HomeDrawerBloc.of(context).updateEndDrawerWidget(
                ScheduleMeetingsMoreFiltersDrawer(bloc),
              );
              Scaffold.of(context).openEndDrawer();
            },
          ),
          _BlueButton(
            titleKey:
                TranslationKeys.Schedule_Meetings_Filter_Panel_Clear_Filters,
            onTap: () => bloc.clearFilters(),
          ),
        ],
      ),
    );
    if (ScreenType.of(context).isMobile) {
      return SizedBox(
        height: 72,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: child,
        ),
      );
    } else {
      return child;
    }
  }
}

class _FilterItem extends StatelessWidget {
  final String titleKey;
  final Widget? filterContainer;
  final bool isSelfControlled;

  const _FilterItem({
    required this.titleKey,
    this.filterContainer,
    this.isSelfControlled = false,
  });

  @override
  Widget build(final BuildContext context) {
    return SheetButton(
      offset: 8,
      button: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 14,
          horizontal: getValueForScreenType(
            context: context,
            mobile: 16,
            tablet: 0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              translate(context, titleKey)!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
      dropDownWidth: 300,
      dropdown: (final _) => DropdownContainer(
        height: isSelfControlled ? null : 400,
        child: filterContainer,
      ),
    );
  }
}

class _BlueButton extends StatelessWidget {
  final String titleKey;
  final VoidCallback? onTap;

  const _BlueButton({
    required this.titleKey,
    this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    return WCInkWell(
      onTap: onTap,
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: getValueForScreenType(
          context: context,
          mobile: 16,
          tablet: 0,
        ),
      ),
      child: Center(
        child: Text(
          translate(context, titleKey)!,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
