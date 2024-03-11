import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/event_code_bloc.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/auth_service.dart';
import '../../../../widgets/cubit.dart';
import 'signup_state.dart';

class SignupBloc extends WCCubit<SignupState> {
  final EventCodeBloc eventCodeBloc;

  SignupBloc({
    required this.eventCodeBloc,
  }) : super(SignupState());

  factory SignupBloc.of(final BuildContext context) =>
      BlocProvider.of<SignupBloc>(context);

  void updateFullName(final String fullName) {
    emit(state.rebuild((final b) => b.fullName = fullName));
  }

  void updateEmail(final String email) {
    emit(state.rebuild((final b) => b.email = email));
  }

  void updatePassword(final String password) {
    emit(state.rebuild((final b) => b.password = password));
  }

  Future<void> signup() async {
    emit(
      state.rebuild(
        (final b) => b.signupApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      await authService.signup(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        eventCode: eventCodeBloc.state!,
      );
      emit(state.rebuild((final b) => b.signupApi.message = 'success'));
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(state.rebuild((final b) => b.signupApi.error = metaData.message));
    }
    emit(state.rebuild((final b) => b.signupApi.isApiInProgress = false));
  }
}
