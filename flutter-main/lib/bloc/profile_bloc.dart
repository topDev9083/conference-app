import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';

import '../models/data/organization_data.dart';
import '../models/data/user_data.dart';
import '../services/auth_service.dart';
import '../services/fcm_service.dart';
import '../services/user_service.dart';
import '../widgets/cubit.dart';
import 'event_bloc.dart';
import 'event_code_bloc.dart';

final _logger = Logger('profile_bloc.dart');

class ProfileBloc extends WCCubit<UserData?> with HydratedMixin {
  final EventBloc eventBloc;
  final EventCodeBloc eventCodeBloc;

  ProfileBloc({
    required this.eventBloc,
    required this.eventCodeBloc,
  }) : super(null) {
    getProfile();
  }

  factory ProfileBloc.of(final BuildContext context) =>
      BlocProvider.of<ProfileBloc>(context);

  void markProfileIsNotWithTemporaryPassword() {
    emit(state?.rebuild((final b) => b.isByTemporaryPassword = false));
  }

  void updateProfile(final UserData? profile) {
    if (state?.authorization == null || profile == null) {
      emit(profile);
    } else {
      emit(
        profile.rebuild(
          (final b) => b
            ..authorization = state!.authorization
            ..isByTemporaryPassword = state!.isByTemporaryPassword,
        ),
      );
    }
    authService.updateCurrentUser(state);
  }

  void updateOrganization(final OrganizationData organization) {
    emit(state?.rebuild((final b) => b.organization.replace(organization)));
  }

  @override
  UserData? fromJson(final Map<String, dynamic> json) {
    final sProfile = json['profile'];
    if (sProfile == null) {
      return null;
    }
    try {
      final profile = UserData.fromDynamic(sProfile);
      authService.updateCurrentUser(profile);
      return profile;
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(final UserData? state) {
    if (state == null) {
      return {};
    }
    return {
      'profile': state.toDynamic(),
    };
  }

  Future<void> getProfile() async {
    if (state == null) {
      return;
    }
    try {
      final profile = await authService.getProfile();
      updateProfile(profile);
    } catch (_) {}
  }

  Future<void> updateFcmToken() async {
    if (state == null) {
      return;
    }
    try {
      await userService.updateFcmToken();
    } catch (e) {
      _logger.severe(e.toString(), e);
    }
  }

  Future<void> logout([final BuildContext? context]) async {
    updateProfile(null);
    eventBloc.resetAccordingToEventCode();
    authService.updateCurrentUser(null);
    await fcmService.deleteToken();
  }
}
