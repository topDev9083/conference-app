import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_code_bloc.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/dialogs.dart';
import 'bloc/forgot_password_bloc.dart';
import 'bloc/forgot_password_state.dart';
import 'forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => ForgotPasswordBloc(
        eventCodeBloc: EventCodeBloc.of(context),
      ),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listenWhen: (final prev, final next) =>
            prev.forgotPasswordApi.message == null &&
            next.forgotPasswordApi.message != null,
        listener: (final _, final __) async {
          final navigator = Navigator.of(context);
          await WCDialog.showInfo(
            context,
            image: 'il_email_sent.png',
            title: translate(
              context,
              TranslationKeys.Auth_Forgot_Password_Check_Mail,
            ),
            subtitle: translate(
              context,
              TranslationKeys.Auth_Forgot_Password_Password_Sent,
            ),
          );
          navigator.pop();
        },
        child: const Scaffold(
          body: Form(
            child: ForgotPasswordForm(),
          ),
        ),
      ),
    );
  }
}
