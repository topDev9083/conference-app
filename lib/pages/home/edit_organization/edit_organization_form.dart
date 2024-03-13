import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/country_selector/country_selector_text_form_field.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/static_grid.dart';
import '../profile/wrappers.dart';
import 'bloc/edit_organization_bloc.dart';
import 'bloc/edit_organization_state.dart';

class EditOrganizationForm extends StatelessWidget {
  const EditOrganizationForm();

  @override
  Widget build(final BuildContext context) {
    final bloc = EditOrganizationBloc.of(context);
    return BlocBuilder<EditOrganizationBloc, EditOrganizationState>(
      builder: (final _, final state) => PContainer(
        child: Column(
          children: [
            _StaticGrid(
              children: [
                TextFormField(
                  initialValue: state.organization.name,
                  textCapitalization: TextCapitalization.words,
                  enabled: !state.updateOrganizationApi.isApiInProgress,
                  onChanged: bloc.updateName,
                  decoration: InputDecoration(
                    labelText: translate(
                      context,
                      TranslationKeys.Edit_Organization_Name,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.required(
                    translate(
                      context,
                      TranslationKeys.Edit_Organization_Error_Name_Required,
                    )!,
                  ),
                ),
                TextFormField(
                  initialValue: state.organization.phoneNumber,
                  keyboardType: TextInputType.phone,
                  enabled: !state.updateOrganizationApi.isApiInProgress,
                  decoration: InputDecoration(
                    labelText: translate(
                      context,
                      TranslationKeys.Edit_Organization_Phone_Number,
                    ),
                    helperText:
                        translate(context, TranslationKeys.General_Optional),
                  ),
                  onChanged: bloc.updatePhoneNumber,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),
                TextFormField(
                  initialValue: state.organization.website,
                  keyboardType: TextInputType.url,
                  enabled: !state.updateOrganizationApi.isApiInProgress,
                  onChanged: bloc.updateWebsite,
                  decoration: InputDecoration(
                    labelText: translate(
                      context,
                      TranslationKeys.Edit_Organization_Website,
                    ),
                    helperText: translate(
                      context,
                      TranslationKeys.General_Optional,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                ),
                TextFormField(
                  initialValue: state.organization.email,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !state.updateOrganizationApi.isApiInProgress,
                  onChanged: bloc.updateEmail,
                  decoration: InputDecoration(
                    labelText: translate(
                      context,
                      TranslationKeys.Edit_Organization_Email,
                    ),
                    helperText: translate(
                      context,
                      TranslationKeys.General_Optional,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(150),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.email(
                    translate(
                      context,
                      TranslationKeys.Auth_Error_Email_Invalid,
                    )!,
                  ),
                ),
              ],
            ),
            SizedBox(height: PWrappersConstants.getVGap(context)),
            TextFormField(
              initialValue: state.organization.address,
              keyboardType: TextInputType.streetAddress,
              enabled: !state.updateOrganizationApi.isApiInProgress,
              onChanged: bloc.updateAddress,
              decoration: InputDecoration(
                labelText: translate(
                  context,
                  TranslationKeys.Edit_Organization_Address,
                ),
                helperText: translate(
                  context,
                  TranslationKeys.General_Optional,
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
            ),
            SizedBox(height: PWrappersConstants.getVGap(context)),
            _StaticGrid(
              columns: getValueForScreenType(
                context: context,
                mobile: 1,
                tablet: 3,
              ),
              children: [
                TextFormField(
                  initialValue: state.organization.city,
                  textCapitalization: TextCapitalization.words,
                  enabled: !state.updateOrganizationApi.isApiInProgress,
                  onChanged: bloc.updateCity,
                  decoration: InputDecoration(
                    labelText: translate(
                      context,
                      TranslationKeys.Edit_Organization_City,
                    ),
                    helperText: translate(
                      context,
                      TranslationKeys.General_Optional,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),
                TextFormField(
                  initialValue: state.organization.state,
                  textCapitalization: TextCapitalization.words,
                  enabled: !state.updateOrganizationApi.isApiInProgress,
                  onChanged: bloc.updateState,
                  decoration: InputDecoration(
                    labelText: translate(
                      context,
                      TranslationKeys.Edit_Organization_State,
                    ),
                    helperText: translate(
                      context,
                      TranslationKeys.General_Optional,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),
                TextFormField(
                  initialValue: state.organization.zipCode,
                  keyboardType: TextInputType.phone,
                  enabled: !state.updateOrganizationApi.isApiInProgress,
                  onChanged: bloc.updateZipCode,
                  decoration: InputDecoration(
                    labelText: translate(
                      context,
                      TranslationKeys.Edit_Organization_Zipcode,
                    ),
                    helperText: translate(
                      context,
                      TranslationKeys.General_Optional,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),
              ],
            ),
            SizedBox(height: PWrappersConstants.getVGap(context)),
            CountrySelectorTextFormField(
              selectedCountry: state.organization.country,
              onCountrySelected: bloc.updateCountry,
              enabled: !state.updateOrganizationApi.isApiInProgress,
            ),
            SizedBox(height: PWrappersConstants.getVGap(context)),
            TextFormField(
              initialValue: state.organization.profile,
              textCapitalization: TextCapitalization.sentences,
              enabled: !state.updateOrganizationApi.isApiInProgress,
              onChanged: bloc.updateProfile,
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                labelText: translate(
                  context,
                  TranslationKeys.Edit_Organization_Profile,
                ),
                helperText: translate(
                  context,
                  TranslationKeys.General_Optional,
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(10000),
              ],
            ),
            SizedBox(height: PWrappersConstants.getVGap(context)),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: WCElevatedButton(
                translate(context, TranslationKeys.General_Update)!,
                showLoader: state.updateOrganizationApi.isApiInProgress,
                onTap: () => _updateOrganization(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateOrganization(final BuildContext context) {
    if (!Form.of(context).validate()) {
      return;
    }
    EditOrganizationBloc.of(context).updateOrganization();
  }
}

class _StaticGrid extends StatelessWidget {
  final List<Widget> children;
  final int? columns;

  const _StaticGrid({
    required this.children,
    this.columns,
  });

  @override
  Widget build(final BuildContext context) {
    return StaticGrid(
      runCrossAxisAlignment: CrossAxisAlignment.start,
      columns: columns ??
          getValueForScreenType(
            context: context,
            mobile: 1,
            tablet: 2,
          ),
      spacing: PWrappersConstants.getVGap(context),
      runSpacing: PWrappersConstants.getHGap(context),
      children: children,
    );
  }
}
