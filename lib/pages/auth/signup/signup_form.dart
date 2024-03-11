import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/text_form_fields.dart';
import '../../../widgets/trn_text.dart';
import '../widgets/auth_form.dart';
import 'bloc/signup_bloc.dart';
import 'bloc/signup_state.dart';

class SignupForm extends StatelessWidget {
  const SignupForm();

  @override
  Widget build(final BuildContext context) {
    final bloc = SignupBloc.of(context);
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (final _, final state) => AuthForm(
        titleKey: TranslationKeys.Auth_Signup_Title,
        subtitle: [
          TextSpan(
            text: translate(
              context,
              TranslationKeys.Auth_Signup_Already_Have_Account,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: WCInkWell(
              padding: const EdgeInsets.all(4),
              onTap: Navigator.of(context).pop,
              child: TrnText(
                TranslationKeys.Auth_Login_Login,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText:
                    translate(context, TranslationKeys.Auth_Signup_Full_Name),
              ),
              onChanged: bloc.updateFullName,
              validator: Validators.required(
                translate(
                  context,
                  TranslationKeys.Auth_Signup_Error_Full_Name_Required,
                )!,
              ),
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              enabled: !state.signupApi.isApiInProgress,
            ),
            const SizedBox(height: 24),
            EmailTextFormField(
              labelKey: TranslationKeys.Auth_Email,
              validator: Validators.compose([
                Validators.required(
                  translate(
                    context,
                    TranslationKeys.Auth_Error_Email_Required,
                  )!,
                ),
                Validators.email(
                  translate(
                    context,
                    TranslationKeys.Auth_Error_Email_Invalid,
                  )!,
                ),
              ]),
              enabled: !state.signupApi.isApiInProgress,
              onChanged: bloc.updateEmail,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 24),
            PasswordTextFormField(
              labelKey: TranslationKeys.Auth_Login_Password,
              validator: Validators.compose([
                Validators.required(
                  TranslationKeys.Auth_Login_Error_Password_Required,
                ),
                Validators.minLength(
                  5,
                  TranslationKeys.Auth_Login_Error_Password_Invalid,
                ),
              ]),
              onChanged: bloc.updatePassword,
              onFieldSubmitted: (final _) => _onSignup(context),
              errorKey: state.signupApi.error,
              enabled: !state.signupApi.isApiInProgress,
            ),
            const SizedBox(height: 40),
            WCElevatedButton(
              translate(context, TranslationKeys.Auth_Signup_Title)!,
              onTap: () => _onSignup(context),
              showLoader: state.signupApi.isApiInProgress,
            ),
          ],
        ),
      ),
    );
  }

  void _onSignup(final BuildContext context) {
    if (!Form.of(context).validate()) {
      return;
    }
    SignupBloc.of(context).signup();
  }
}
