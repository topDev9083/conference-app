import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/bloc_listener.dart';
import '../../../widgets/grey_header.dart';
import 'bloc/edit_organization_bloc.dart';
import 'bloc/edit_organization_state.dart';
import 'edit_organization_form.dart';
import 'edit_organization_logo.dart';

class EditOrganizationFragment extends StatelessWidget {
  const EditOrganizationFragment();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => EditOrganizationBloc(
        profileBloc: ProfileBloc.of(context),
        organization: ProfileBloc.of(context).state?.organization,
      ),
      child: ErrorBlocListener<EditOrganizationBloc, EditOrganizationState>(
        errorWhen: (final state) => state.updateOrganizationApi.error,
        child: Form(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: getValueForScreenType(
                context: context,
                mobile: EdgeInsets.zero,
                tablet: const EdgeInsets.symmetric(
                  horizontal: 27,
                  vertical: 27,
                ),
              ),
              children: const [
                GreyHeader(
                  titleKey: TranslationKeys.Edit_Organization_Title,
                  subtitleKey: TranslationKeys.Edit_Organization_Subtitle,
                ),
                EditOrganizationLogo(),
                SizedBox(height: 30),
                EditOrganizationForm(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
