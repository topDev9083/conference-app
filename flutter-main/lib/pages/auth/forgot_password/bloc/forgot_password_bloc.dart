import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/event_code_bloc.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/auth_service.dart';
import '../../../../widgets/cubit.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends WCCubit<ForgotPasswordState> {
  final EventCodeBloc eventCodeBloc;

  ForgotPasswordBloc({
    required this.eventCodeBloc,
  }) : super(ForgotPasswordState());

  factory ForgotPasswordBloc.of(final BuildContext context) =>
      BlocProvider.of<ForgotPasswordBloc>(context);

  void updateEmail(final String? email) {
    emit(
      state.rebuild(
        (final b) => b
          ..email = email
          ..forgotPasswordApi.error = null,
      ),
    );
  }

  Future<void> forgotPassword() async {
    emit(
      state.rebuild(
        (final b) => b
          ..forgotPasswordApi.isApiInProgress = true
          ..forgotPasswordApi.error = null,
      ),
    );
    try {
      final response = await authService.forgotPassword(
        state.email,
        eventCodeBloc.state!,
      );
      emit(
        state.rebuild(
          (final b) => b.forgotPasswordApi.message = response.message,
        ),
      );
    } catch (e) {
      final meta = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.forgotPasswordApi.error = meta.message),
      );
    }
    emit(
      state.rebuild((final b) => b.forgotPasswordApi.isApiInProgress = false),
    );
  }
}
