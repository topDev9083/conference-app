import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_code_bloc.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/dialogs.dart';
import 'bloc/signup_bloc.dart';
import 'bloc/signup_state.dart';
import 'signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => SignupBloc(
        eventCodeBloc: EventCodeBloc.of(context),
      ),
      child: BlocListener<SignupBloc, SignupState>(
        listenWhen: (final prev, final next) =>
            prev.signupApi.message == null && next.signupApi.message != null,
        listener: (final _, final state) async {
          final navigator = Navigator.of(context);
          await WCDialog.showInfo(
            context,
            title:
                translate(context, TranslationKeys.Auth_Signup_Success_Title),
            subtitle: translate(
              context,
              TranslationKeys.Auth_Signup_Success_Subtitle,
            ),
          );
          navigator.pop();
        },
        child: const Scaffold(
          body: Form(
            child: SignupForm(),
          ),
        ),
      ),
    );
  }
}
