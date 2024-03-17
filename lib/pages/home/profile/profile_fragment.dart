import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/automatic_keep_alive_client.dart';
import '../../../widgets/bloc_listener.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/grey_header.dart';
import '../../change_password/change_password_dialog.dart';
import 'bloc/edit_profile_bloc.dart';
import 'bloc/edit_profile_state.dart';
import 'colleagues.dart';
import 'fill_profile.dart';
import 'filters.dart';
import 'social_media.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment();

  @override
  Widget build(final BuildContext context) {
    return Form(
      child: BlocProvider(
        create: (final _) => EditProfileBloc(
          profileBloc: ProfileBloc.of(context),
        ),
        child: ErrorBlocListener<EditProfileBloc, EditProfileState>(
          errorWhen: (final state) => state.updateProfileApi.error,
          child: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (final context, final state) => Container(
              color: Colors.white,
              child: state.getCustomFieldsApi.data == null
                  ? Center(
                      child: ConnectionInformation(
                        error: state.getCustomFieldsApi.error,
                        onRetry: EditProfileBloc.of(context).getCustomFields,
                      ),
                    )
                  : ListView(
                      padding: getValueForScreenType(
                        context: context,
                        mobile: EdgeInsets.zero,
                        tablet: const EdgeInsets.symmetric(
                          horizontal: 27,
                          vertical: 27,
                        ),
                      ),
                      children: [
                        const GreyHeader(
                          titleKey: TranslationKeys.Profile_Profile,
                          subtitleKey: TranslationKeys.Profile_Fill_Profile,
                        ),
                        const AutomaticKeepAliveClient(
                          child: FillProfile(),
                        ),
                        if (state.getCustomFieldsApi.data!.isNotEmpty) ...[
                          const GreyHeader(
                            titleKey: TranslationKeys.Profile_Filters,
                            subtitleKey: TranslationKeys.Profile_Fill_Filters,
                          ),
                          const SizedBox(height: 16),
                          const AutomaticKeepAliveClient(
                            child: Filters(),
                          ),
                        ],
                        const GreyHeader(
                          titleKey: TranslationKeys.Profile_Social_Media,
                          subtitleKey:
                              TranslationKeys.Profile_Fill_Social_Media,
                        ),
                        const SizedBox(height: 16),
                        const AutomaticKeepAliveClient(
                          child: SocialMedia(),
                        ),
                        if (state.getColleaguesApi.data == null) ...[
                          Center(
                            child: ConnectionInformation(
                              error: state.getColleaguesApi.error,
                              onRetry:
                                  EditProfileBloc.of(context).getColleagues,
                            ),
                          ),
                        ] else ...[
                          if (state.getColleaguesApi.data!.isNotEmpty) ...[
                            const GreyHeader(
                              titleKey: TranslationKeys.Profile_Colleagues,
                              subtitleKey:
                                  TranslationKeys.Profile_Colleagues_Subtitle,
                            ),
                            const Colleagues(),
                          ],
                        ],
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            WCElevatedButton(
                              translate(
                                context,
                                TranslationKeys.Change_Password_Title,
                              )!,
                              onTap: () => ChangePasswordDialog.show(context),
                            ),
                            const SizedBox(width: 16),
                            WCElevatedButton(
                              translate(
                                context,
                                TranslationKeys.General_Update,
                              )!,
                              showLoader:
                                  state.updateProfileApi.isApiInProgress,
                              onTap: () => _onUpdateProfile(context),
                            ),
                            SizedBox(
                              width: getValueForScreenType(
                                context: context,
                                mobile: 23,
                                tablet: 0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _onUpdateProfile(final BuildContext context) {
    final form = Form.of(context);
    if (!form.validate()) {
      return;
    }
    form.save();
    EditProfileBloc.of(context).updateProfile();
  }
}
