import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/text_form_fields.dart';
import '../../../widgets/trn_text.dart';
import '../widgets/auth_form.dart';
import 'bloc/forgot_password_bloc.dart';
import 'bloc/forgot_password_state.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm();

  @override
  Widget build(final BuildContext context) {
    final bloc = ForgotPasswordBloc.of(context);
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (final _, final state) => AuthForm(
        titleKey: TranslationKeys.Auth_Forgot_Password_Title,
        subtitle: [
          TextSpan(
            text: translate(
              context,
              TranslationKeys.Auth_Forgot_Password_Enter_Email,
            ),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmailTextFormField(
              labelKey: TranslationKeys.Auth_Email,
              errorKey: state.forgotPasswordApi.error,
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
              enabled: !state.forgotPasswordApi.isApiInProgress,
              onChanged: bloc.updateEmail,
              onFieldSubmitted: (final _) => _onResetPassword(context),
            ),
            const SizedBox(height: 40),
            WCElevatedButton(
              translate(
                context,
                TranslationKeys.Auth_Forgot_Password_Reset_Password,
              )!,
              onTap: () => _onResetPassword(context),
              showLoader: state.forgotPasswordApi.isApiInProgress,
            ),
            const SizedBox(height: 32),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  children: [
                    TextSpan(
                      text: translate(
                        context,
                        TranslationKeys.Auth_Forgot_Password_Return_To,
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
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onResetPassword(final BuildContext context) {
    final bloc = ForgotPasswordBloc.of(context);
    final form = Form.of(context);

    if (!form.validate()) {
      return;
    }
    form.save();
    bloc.forgotPassword();
  }
}
