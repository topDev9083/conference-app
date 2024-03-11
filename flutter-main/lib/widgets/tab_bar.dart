import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../bloc/event_bloc.dart';
import '../core/colors.dart';
import '../extensions/date_time.dart';
import '../flutter_i18n/translation_keys.dart';
import 'ink_well.dart';
import 'time_zone_bloc_builder.dart';

class WCTabBar extends StatelessWidget {
  final List<TabData> items;

  const WCTabBar({
    required this.items,
  });

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
            context: context,
            mobile: 16,
            tablet: 26,
          ),
        ),
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _TabItem(
              items[i].title,
              onTap: items[i].onTap,
              isSelected: items[i].isSelected,
              isFirst: i == 0,
              isLast: i == items.length - 1,
            ),
          ],
        ],
      ),
    );
  }
}

class TabData {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  TabData(
    this.title, {
    this.isSelected = false,
    this.onTap,
  });
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isFirst;
  final bool isLast;
  final bool isSelected;
  final VoidCallback? onTap;

  const _TabItem(
    this.title, {
    this.onTap,
    this.isSelected = false,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(final BuildContext context) {
    const borderSide = BorderSide(
      color: WCColors.grey_d9,
      width: 2,
    );
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        border: BorderDirectional(
          top: borderSide,
          bottom: borderSide,
          start: borderSide.copyWith(
            width: isFirst ? 2 : 1,
          ),
          end: borderSide.copyWith(
            width: isLast ? 2 : 1,
          ),
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.38),
                  offset: const Offset(0.8, 5.9),
                  blurRadius: 29,
                ),
              ]
            : null,
      ),
      child: WCInkWell(
        isDark: isSelected,
        padding: const EdgeInsets.symmetric(
          horizontal: 27,
        ),
        onTap: onTap,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: (isSelected ? Colors.white : WCColors.black_09)
                  .withOpacity(0.93),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class EventTabBar extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?>? onTabSelected;

  const EventTabBar({
    this.selectedDate,
    this.onTabSelected,
  });

  @override
  Widget build(final BuildContext context) {
    final bloc = EventBloc.of(context);
    final dates = bloc.getEventDates();
    return TimeZoneBlocBuilder(
      builder: (final timeZone) => WCTabBar(
        items: [
          TabData(
            translate(context, TranslationKeys.Tabs_All_Days)!,
            isSelected: selectedDate == null,
            onTap: () => onTabSelected?.call(null),
          ),
          for (int i = 0; i < dates.length; i++) ...[
            TabData(
              dates[i].format(
                format: 'EEE, dd MMM',
                timeZone: timeZone,
              ),
              isSelected: selectedDate.toString() == dates[i].toString(),
              onTap: () => onTabSelected?.call(dates[i]),
            ),
          ],
        ],
      ),
    );
  }
}
