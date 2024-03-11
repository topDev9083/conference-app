import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/event_code_bloc.dart';
import '../../../../bloc/profile_bloc.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/auth_service.dart';
import '../../../../widgets/cubit.dart';
import 'login_state.dart';

class LoginBloc extends WCCubit<LoginState> {
  final ProfileBloc profileBloc;
  final EventCodeBloc eventCodeBloc;

  LoginBloc({
    required this.profileBloc,
    required this.eventCodeBloc,
  }) : super(LoginState());

  factory LoginBloc.of(final BuildContext context) =>
      BlocProvider.of<LoginBloc>(context);

  void updateEmail(final String? email) {
    emit(
      state.rebuild(
        (final b) => b
          ..email = email
          ..emailError = null
          ..passwordError = null,
      ),
    );
  }

  void updatePassword(final String? password) {
    emit(
      state.rebuild(
        (final b) => b
          ..password = password
          ..emailError = null
          ..passwordError = null,
      ),
    );
  }

  Future<void> login() async {
    emit(
      state.rebuild(
        (final b) => b
          ..api.isApiInProgress = true
          ..emailError = null
          ..passwordError = null,
      ),
    );
    try {
      final profile = await authService.login(
        email: state.email,
        password: state.password,
        eventCode: eventCodeBloc.state!,
      );
      profileBloc.updateProfile(profile);
    } catch (e) {
      final meta = ApiResponse.getStrongMetaData(e);
      if (meta.key == 'string.email') {
        emit(state.rebuild((final b) => b.emailError = meta.message));
      } else {
        emit(state.rebuild((final b) => b.passwordError = meta.message));
      }
    }
    emit(state.rebuild((final b) => b.api.isApiInProgress = false));
  }
}
