import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../models/response/api_response.dart';
import '../../../services/user_service.dart';
import '../../../widgets/cubit.dart';
import 'change_password_state.dart';

class ChangePasswordBloc extends WCCubit<ChangePasswordState> {
  final ProfileBloc profileBloc;

  ChangePasswordBloc({
    required this.profileBloc,
  }) : super(ChangePasswordState());

  factory ChangePasswordBloc.of(final BuildContext context) =>
      BlocProvider.of<ChangePasswordBloc>(context);

  void updateCurrentPassword(final String currentPassword) {
    emit(
      state.rebuild(
        (final b) => b
          ..currentPassword = currentPassword
          ..changePasswordApi.error = null,
      ),
    );
  }

  void updateNewPassword(final String newPassword) {
    emit(
      state.rebuild(
        (final b) => b
          ..newPassword = newPassword
          ..changePasswordApi.error = null,
      ),
    );
  }

  void updateConfirmPassword(final String confirmPassword) {
    emit(
      state.rebuild(
        (final b) => b
          ..confirmPassword = confirmPassword
          ..changePasswordApi.error = null,
      ),
    );
  }

  Future<void> changePassword() async {
    emit(
      state.rebuild(
        (final b) => b.changePasswordApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );

    try {
      await userService.changePassword(
        currentPassword: state.currentPassword,
        newPassword: state.newPassword,
      );
      profileBloc.markProfileIsNotWithTemporaryPassword();
      emit(state.rebuild((final b) => b.changePasswordApi.message = 'success'));
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state
            .rebuild((final b) => b.changePasswordApi.error = metaData.message),
      );
    }
    emit(
      state.rebuild((final b) => b.changePasswordApi.isApiInProgress = false),
    );
  }
}
