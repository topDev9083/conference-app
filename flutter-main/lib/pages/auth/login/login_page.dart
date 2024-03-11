import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_code_bloc.dart';
import '../../../bloc/profile_bloc.dart';
import 'bloc/login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => LoginBloc(
        profileBloc: ProfileBloc.of(context),
        eventCodeBloc: EventCodeBloc.of(context),
      ),
      child: const Scaffold(
        body: Form(
          child: LoginForm(),
        ),
      ),
    );
  }
}
