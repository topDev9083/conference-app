import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/image.dart';
import '../../../widgets/static_grid.dart';
import 'bloc/edit_profile_bloc.dart';
import 'bloc/edit_profile_state.dart';
import 'wrappers.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia();

  @override
  Widget build(final BuildContext context) {
    final bloc = EditProfileBloc.of(context);
    final profile = ProfileBloc.of(context).state!;
    return PContainer(
      child: StaticGrid(
        spacing: PWrappersConstants.getVGap(context),
        runSpacing: PWrappersConstants.getHGap(context),
        columns: getValueForScreenType(
          context: context,
          mobile: 1,
          tablet: 2,
        ),
        children: [
          _SocialField(
            initialValue: profile.linkedInUsername,
            icon: 'linkedin.png',
            baseUrl: LINKED_IN_BASE_URL,
            hintKey: TranslationKeys.Profile_Linkdin_Username,
            onSaved: (final value) => bloc.updateLinkedInUsername(value ?? ''),
          ),
          _SocialField(
            initialValue: profile.twitterUsername,
            icon: 'twitter.png',
            baseUrl: TWITTER_BASE_URL,
            hintKey: TranslationKeys.Profile_Twitter_Username,
            onSaved: (final value) => bloc.updateTwitterUsername(value ?? ''),
          ),
          _SocialField(
            initialValue: profile.facebookUsername,
            icon: 'facebook.png',
            baseUrl: FACEBOOK_BASE_URL,
            hintKey: TranslationKeys.Profile_Facebook_Username,
            onSaved: (final value) => bloc.updateFacebookUsername(value ?? ''),
          ),
          _SocialField(
            initialValue: profile.skypeUsername,
            icon: 'skype.png',
            baseUrl: SKYPE_BASE_URL,
            hintKey: TranslationKeys.Profile_Skype_Username,
            onSaved: (final value) => bloc.updateSkypeUsername(value ?? ''),
          ),
        ],
      ),
    );
  }
}

class _SocialField extends StatelessWidget {
  final String hintKey;
  final String baseUrl;
  final String icon;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;

  const _SocialField({
    required this.hintKey,
    required this.baseUrl,
    required this.icon,
    this.initialValue,
    this.onSaved,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (final context, final state) => TextFormField(
        enabled: !state.updateProfileApi.isApiInProgress,
        initialValue: initialValue,
        style: const TextStyle(
          fontSize: 14,
        ),
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: translate(context, hintKey),
          hintStyle: const TextStyle(
            fontSize: 14,
            color: WCColors.grey_bb,
          ),
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 11),
              WCImage(
                image: icon,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 12),
              Text(
                baseUrl.replaceAll('https://', ''),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
