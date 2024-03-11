import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile_bloc.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../widgets/close_icon.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/keyboard_remover.dart';
import '../../widgets/trn_text.dart';
import 'bloc/change_password_bloc.dart';
import 'bloc/change_password_state.dart';
import 'change_password_form.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog._();

  static Future<void> show(final BuildContext context) {
    return showDialog(
      context: context,
      builder: (final _) => BlocProvider(
        create: (final _) => ChangePasswordBloc(
          profileBloc: ProfileBloc.of(context),
        ),
        child: const Dialog(
          child: KeyboardRemover(
            child: ChangePasswordDialog._(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listenWhen: (final prev, final next) =>
          prev.changePasswordApi.message == null &&
          next.changePasswordApi.message != null,
      listener: (final context, final __) => Navigator.of(context).pop(),
      child: Form(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: DIALOG_WIDTH,
          ),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 7,
                    end: 7,
                  ),
                  child: CloseIcon(
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const TrnText(
                TranslationKeys.Change_Password_Title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const TrnText(
                TranslationKeys.Change_Password_Subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: WCColors.grey_9f,
                ),
              ),
              const SizedBox(height: 16),
              const ChangePasswordForm(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _ChangePasswordButton(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangePasswordButton extends StatelessWidget {
  const _ChangePasswordButton();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (final _, final state) => WCElevatedButton(
        translate(context, TranslationKeys.Change_Password_Change_Password)!,
        showLoader: state.changePasswordApi.isApiInProgress,
        onTap: () => _onChangePassword(context),
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
