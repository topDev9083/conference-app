import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/custom_field_data.dart';
import '../../../models/enums/custom_field_type.dart';
import '../../../utils/color_utils.dart';
import '../../../widgets/close_icon.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/full_screen_drawer.dart';
import '../../../widgets/ink_well.dart';
import 'bloc/schedule_meetings_bloc.dart';
import 'bloc/schedule_meetings_state.dart';

class ScheduleMeetingsMoreFiltersDrawer extends StatelessWidget {
  final ScheduleMeetingsBloc bloc;

  const ScheduleMeetingsMoreFiltersDrawer(this.bloc);

  @override
  Widget build(final BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ScheduleMeetingsBloc, ScheduleMeetingsState>(
        builder: (final _, final state) => FullScreenDrawer(
          width: 361,
          child: Container(
            color: ColorUtils.lighten(
              Theme.of(context).primaryColor,
              0.95,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          translate(
                            context,
                            TranslationKeys
                                .Schedule_Meetings_Filter_Panel_Apply_Filters,
                          )!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      CloseIcon(
                        bgColor: Colors.white,
                        onTap: Navigator.of(context).pop,
                      ),
                      // if(false)
                    ],
                  ),
                ),
                Expanded(
                  child: state.customFieldsApi.data == null
                      ? Center(
                          child: ConnectionInformation(
                            error: state.customFieldsApi.error,
                            onRetry: bloc.getCustomFields,
                          ),
                        )
                      : const _Filters(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters();

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingsBloc.of(context);
    return BlocBuilder<ScheduleMeetingsBloc, ScheduleMeetingsState>(
      builder: (final _, final state) {
        final checkableGroups = bloc.getCustomFieldsByTypes([
          CustomFieldType.radioGroup,
          CustomFieldType.checkboxGroup,
        ])!;
        final checkableSingle = bloc.getCustomFieldsByTypes([
          CustomFieldType.checkboxSingle,
        ])!;
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          children: [
            for (final group in checkableGroups) ...[
              const SizedBox(height: 19),
              _FilterBox(
                title: group.name,
                children: group.children!,
              ),
            ],
            if (checkableSingle.isNotEmpty) ...[
              const SizedBox(height: 19),
              _FilterBox(
                title: translate(
                  context,
                  TranslationKeys.Schedule_Meetings_Filter_Panel_Others,
                )!,
                children: checkableSingle,
              ),
            ],
            const SizedBox(height: 22),
          ],
        );
      },
    );
  }
}

class _FilterBox extends StatelessWidget {
  final String title;
  final BuiltList<CustomFieldData> children;

  const _FilterBox({
    required this.title,
    required this.children,
  });

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingsBloc.of(context);
    final state = bloc.state;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          for (final field in children) ...[
            _CheckBox(
              title: field.name,
              value: state.selectedCustomFieldIds.contains(field.id),
              onChanged: (final value) => value
                  ? bloc.addCustomFieldId(field.id)
                  : bloc.removeCustomFieldId(field.id),
            ),
          ],
        ],
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  final String title;
  final ValueChanged<bool> onChanged;
  final bool value;

  const _CheckBox({
    required this.title,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(final BuildContext context) {
    return WCInkWell(
      onTap: () => onChanged(!value),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (final value) => onChanged(value == true),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color:
                    value ? Theme.of(context).primaryColor : WCColors.grey_b7,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
