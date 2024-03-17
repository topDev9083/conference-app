import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/custom_field_data.dart';
import '../../../models/enums/custom_field_type.dart';
import '../../../utils/text_input_formatter.dart';
import '../../../widgets/static_grid.dart';
import 'bloc/edit_profile_bloc.dart';
import 'bloc/edit_profile_state.dart';
import 'wrappers.dart';

class Filters extends StatelessWidget {
  const Filters();

  @override
  Widget build(final BuildContext context) {
    final bloc = EditProfileBloc.of(context);
    final stringTFS =
        bloc.getCustomFieldsByType(CustomFieldType.textFieldString)!;
    final numberTFS =
        bloc.getCustomFieldsByType(CustomFieldType.textFieldNumber)!;
    final checkboxSingles =
        bloc.getCustomFieldsByType(CustomFieldType.checkboxSingle)!;
    final checkboxGroups =
        bloc.getCustomFieldsByType(CustomFieldType.checkboxGroup)!;
    final radioGroups = bloc.getCustomFieldsByType(CustomFieldType.radioGroup)!;
    return PContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaticGrid(
            spacing: PWrappersConstants.getHGap(context),
            runSpacing: PWrappersConstants.getVGap(context),
            columns: getValueForScreenType(
              context: context,
              mobile: 1,
              tablet: 2,
            ),
            children: [
              ...stringTFS.map((final cf) => _StringField(cf)),
              ...numberTFS.map((final cf) => _NumberField(cf)),
            ],
          ),
          if (checkboxSingles.isNotEmpty) ...[
            SizedBox(height: PWrappersConstants.getHGap(context)),
            Wrap(
              spacing: PWrappersConstants.getHGap(context),
              runSpacing: PWrappersConstants.getVGap(context),
              children: checkboxSingles
                  .map((final cf) => _SingleCheckboxField(cf))
                  .toList(),
            ),
          ],
          if (checkboxGroups.isNotEmpty) ...[
            SizedBox(height: PWrappersConstants.getHGap(context)),
            StaticGrid(
              runSpacing: PWrappersConstants.getHGap(context),
              children: checkboxGroups
                  .map((final cf) => _GroupedCheckboxField(cf))
                  .toList(),
            ),
          ],
          if (radioGroups.isNotEmpty) ...[
            SizedBox(height: PWrappersConstants.getHGap(context)),
            StaticGrid(
              runSpacing: PWrappersConstants.getHGap(context),
              children: radioGroups
                  .map((final cf) => _GroupedRadioField(cf))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _StringField extends StatelessWidget {
  final CustomFieldData cf;

  const _StringField(this.cf);

  @override
  Widget build(final BuildContext context) {
    final bloc = EditProfileBloc.of(context);
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (final context, final state) => TextFormField(
        initialValue: state.customFieldsValues.asMap['${cf.id}'] as String?,
        decoration: InputDecoration(
          labelText: cf.name,
          helperText: translate(context, TranslationKeys.General_Optional),
          enabled: !state.updateProfileApi.isApiInProgress,
        ),
        onSaved: (final value) => bloc.updateStringCustomField(cf.id, value),
        inputFormatters: [
          LengthLimitingTextInputFormatter(250),
        ],
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  final CustomFieldData cf;

  const _NumberField(this.cf);

  @override
  Widget build(final BuildContext context) {
    final bloc = EditProfileBloc.of(context);
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (final context, final state) => TextFormField(
        initialValue: state.customFieldsValues.asMap['${cf.id}']?.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: cf.name,
          helperText: translate(context, TranslationKeys.General_Optional),
          enabled: !state.updateProfileApi.isApiInProgress,
        ),
        onSaved: (final value) =>
            bloc.updateNumberCustomField(cf.id, value ?? ''),
        inputFormatters: [
          LengthLimitingTextInputFormatter(250),
          NumbersTextInputFormatter(),
        ],
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const _CheckBox({
    required this.text,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: WCColors.black_09.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class _SingleCheckboxField extends StatelessWidget {
  final CustomFieldData cf;

  const _SingleCheckboxField(this.cf);

  @override
  Widget build(final BuildContext context) {
    final bloc = EditProfileBloc.of(context);
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (final context, final state) => _CheckBox(
        text: cf.name,
        value: state.customFieldsValues.asMap['${cf.id}'] as bool? ?? false,
        onChanged: state.updateProfileApi.isApiInProgress
            ? null
            : (final value) => bloc.updateBoolCustomField(
                  cfId: cf.id,
                  value: value == true,
                ),
      ),
    );
  }
}

class _GroupedCheckboxField extends StatelessWidget {
  final CustomFieldData cf;

  const _GroupedCheckboxField(this.cf);

  @override
  Widget build(final BuildContext context) {
    final bloc = EditProfileBloc.of(context);
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (final context, final state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            cf.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: PWrappersConstants.getHGap(context),
            // runSpacing: PWrappersConstants.getVGap(context),
            children: cf.children!
                .map(
                  (final childCf) => _CheckBox(
                    text: childCf.name,
                    value:
                        state.customFieldsValues.asMap['${childCf.id}'] == true,
                    onChanged: state.updateProfileApi.isApiInProgress
                        ? null
                        : (final value) => bloc.updateBoolCustomField(
                              cfId: childCf.id,
                              value: value == true,
                            ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _RadioField extends StatelessWidget {
  final CustomFieldData parent;
  final CustomFieldData child;

  const _RadioField({
    required this.parent,
    required this.child,
  });

  @override
  Widget build(final BuildContext context) {
    final bloc = EditProfileBloc.of(context);
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (final context, final state) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<int>(
            value: child.id,
            groupValue: bloc.getSelectedCustomFieldChildIdOfParentId(parent.id),
            onChanged: state.updateProfileApi.isApiInProgress
                ? null
                : (final value) => bloc.updateBoolCustomField(
                      cfId: child.id,
                      value: true,
                      parentId: parent.id,
                    ),
          ),
          Text(
            child.name,
            style: TextStyle(
              fontSize: 13,
              color: WCColors.black_09.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupedRadioField extends StatelessWidget {
  final CustomFieldData cf;

  const _GroupedRadioField(this.cf);

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          cf.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: PWrappersConstants.getHGap(context),
          // runSpacing: PWrappersConstants.getVGap(context),
          children: cf.children!
              .map(
                (final childCf) => _RadioField(
                  child: childCf,
                  parent: cf,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
