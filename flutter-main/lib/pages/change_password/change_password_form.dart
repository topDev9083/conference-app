import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../flutter_i18n/translation_keys.dart';
import '../../widgets/text_form_fields.dart';
import 'bloc/change_password_bloc.dart';
import 'bloc/change_password_state.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm();

  @override
  Widget build(final BuildContext context) {
    final bloc = ChangePasswordBloc.of(context);
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (final _, final state) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PasswordTextFormField(
              labelKey: TranslationKeys.Change_Password_Current_Password,
              onChanged: bloc.updateCurrentPassword,
              errorKey: state.changePasswordApi.error,
              enabled: !state.changePasswordApi.isApiInProgress,
              onFieldSubmitted: (final _) => _onChangePassword(context),
              validator: Validators.compose([
                Validators.required(
                  translate(
                    context,
                    TranslationKeys
                        .Change_Password_Error_Current_Password_Required,
                  )!,
                ),
              ]),
            ),
            const SizedBox(height: 16),
            PasswordTextFormField(
              labelKey: TranslationKeys.Change_Password_New_Password,
              onChanged: bloc.updateNewPassword,
              enabled: !state.changePasswordApi.isApiInProgress,
              onFieldSubmitted: (final _) => _onChangePassword(context),
              validator: Validators.compose([
                Validators.required(
                  translate(
                    context,
                    TranslationKeys.Change_Password_Error_New_Password_Required,
                  )!,
                ),
                Validators.minLength(
                  5,
                  translate(
                    context,
                    TranslationKeys.Auth_Login_Error_Password_Invalid,
                  )!,
                ),
              ]),
            ),
            const SizedBox(height: 16),
            PasswordTextFormField(
              labelKey: TranslationKeys.Change_Password_Confirm_Password,
              onChanged: bloc.updateConfirmPassword,
              enabled: !state.changePasswordApi.isApiInProgress,
              onFieldSubmitted: (final _) => _onChangePassword(context),
              validator: Validators.compose([
                Validators.required(
                  translate(
                    context,
                    TranslationKeys
                        .Change_Password_Error_Confirm_Password_Required,
                  )!,
                ),
                (final value) => state.newPassword == value
                    ? null
                    : translate(
                        context,
                        TranslationKeys
                            .Change_Password_Error_Confirm_Password_Invalid,
                      ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _onChangePassword(final BuildContext context) {
    final form = Form.of(context);
    if (!form.validate()) {
      return;
    }
    ChangePasswordBloc.of(context).changePassword();
  }
}
