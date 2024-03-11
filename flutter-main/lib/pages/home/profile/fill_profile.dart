import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/user_data.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/qr_code.dart';
import '../../../widgets/static_grid.dart';
import '../../qr_code/qr_code_dialog.dart';
import 'bloc/edit_profile_bloc.dart';
import 'bloc/edit_profile_state.dart';
import 'wrappers.dart';

class FillProfile extends StatelessWidget {
  const FillProfile();

  @override
  Widget build(final BuildContext context) {
    return const PContainer(
      child: Column(
        children: [
          _BasicInfo(),
          SizedBox(height: 20),
          _Fields(),
        ],
      ),
    );
  }
}

class _BasicInfo extends StatelessWidget {
  const _BasicInfo();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ProfileBloc, UserData?>(
      builder: (final _, final profile) =>
          BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (final context, final state) => Row(
          children: [
            Stack(
              children: [
                WCInkWell(
                  isDark: true,
                  isOverLay: true,
                  isCircle: true,
                  onTap: state.updateProfileApi.isApiInProgress
                      ? null
                      : () => _onPickProfilePicture(context),
                  child: UserAvatar(
                    profilePicture: profile?.profilePicture,
                    file: state.profilePicture,
                    size: 67,
                    borderRadius: 999,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: WCInkWell(
                      isDark: true,
                      isOverLay: true,
                      isCircle: true,
                      onTap: state.updateProfileApi.isApiInProgress
                          ? null
                          : () => _onPickProfilePicture(context),
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 17),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile?.fullName ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (profile?.jobAtOrganization != null) ...[
                    Text(
                      profile!.jobAtOrganization!,
                      style: TextStyle(
                        fontSize: 12,
                        color: WCColors.black_09.withOpacity(0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            WCInkWell(
              isOverLay: true,
              onTap: () => QrCodeDialog.show(context),
              child: const QrCode(
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPickProfilePicture(final BuildContext context) async {
    final editProfileBloc = EditProfileBloc.of(context);
    final imageFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (imageFiles == null || imageFiles.count == 0) {
      return;
    }
    final imageFile = imageFiles.files.first;
    editProfileBloc.updateProfilePic(imageFile);
  }
}

class _Fields extends StatelessWidget {
  const _Fields();

  @override
  Widget build(final BuildContext context) {
    final profile = ProfileBloc.of(context).state!;
    final bloc = EditProfileBloc.of(context);
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (final _, final state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaticGrid(
            spacing: PWrappersConstants.getVGap(context),
            runSpacing: PWrappersConstants.getHGap(context),
            columns: getValueForScreenType(
              context: context,
              mobile: 1,
              tablet: 2,
            ),
            children: [
              AbsorbPointer(
                child: TextFormField(
                  initialValue: profile.firstName,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText:
                        translate(context, TranslationKeys.Profile_First_Name),
                    helperText:
                        translate(context, TranslationKeys.General_Readonly),
                  ),
                ),
              ),
              AbsorbPointer(
                child: TextFormField(
                  initialValue: profile.lastName,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText:
                        translate(context, TranslationKeys.Profile_Last_Name),
                    helperText:
                        translate(context, TranslationKeys.General_Readonly),
                  ),
                ),
              ),
              AbsorbPointer(
                child: TextFormField(
                  initialValue: profile.email,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText:
                        translate(context, TranslationKeys.Profile_Email),
                    helperText:
                        translate(context, TranslationKeys.General_Readonly),
                  ),
                ),
              ),
              TextFormField(
                initialValue: profile.phoneNumber,
                keyboardType: TextInputType.phone,
                enabled: !state.updateProfileApi.isApiInProgress,
                decoration: InputDecoration(
                  labelText:
                      translate(context, TranslationKeys.Profile_Phone_Number),
                  helperText:
                      translate(context, TranslationKeys.General_Optional),
                ),
                onSaved: (final value) => bloc.updatePhoneNumber(value ?? ''),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
              ),
            ],
          ),
          SizedBox(
            height: PWrappersConstants.getHGap(context),
          ),
          TextFormField(
            initialValue: profile.jobTitle,
            enabled: !state.updateProfileApi.isApiInProgress,
            decoration: InputDecoration(
              labelText: translate(context, TranslationKeys.Profile_Job_Title),
              helperText: translate(context, TranslationKeys.General_Optional),
            ),
            onSaved: (final value) => bloc.updateJobTitle(value ?? ''),
            inputFormatters: [
              LengthLimitingTextInputFormatter(150),
            ],
          ),
          SizedBox(
            height: PWrappersConstants.getHGap(context),
          ),
          TextFormField(
            initialValue: profile.bio,
            enabled: !state.updateProfileApi.isApiInProgress,
            decoration: InputDecoration(
              labelText: translate(context, TranslationKeys.Profile_Bio),
              helperText: translate(context, TranslationKeys.General_Optional),
            ),
            minLines: 5,
            maxLines: 20,
            onSaved: (final value) => bloc.updateBio(value ?? ''),
            inputFormatters: [
              LengthLimitingTextInputFormatter(10000),
            ],
          ),
        ],
      ),
    );
  }
}
