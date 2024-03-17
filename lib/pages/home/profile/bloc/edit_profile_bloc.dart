import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/profile_bloc.dart';
import '../../../../extensions/iterable.dart';
import '../../../../models/data/custom_field_data.dart';
import '../../../../models/data/user_data.dart';
import '../../../../models/enums/custom_field_type.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/custom_field_service.dart';
import '../../../../services/user_service.dart';
import '../../../../widgets/cubit.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends WCCubit<EditProfileState> {
  final ProfileBloc profileBloc;

  EditProfileBloc({
    required this.profileBloc,
  }) : super(
          EditProfileState(
            (final b) => b
              ..customFieldsValues = profileBloc.state!.customFieldsValues
              ..phoneNumber = profileBloc.state!.phoneNumber
              ..jobTitle = profileBloc.state!.jobTitle
              ..bio = profileBloc.state!.bio
              ..linkedInUsername = profileBloc.state!.linkedInUsername
              ..twitterUsername = profileBloc.state!.twitterUsername
              ..facebookUsername = profileBloc.state!.facebookUsername
              ..skypeUsername = profileBloc.state!.skypeUsername,
          ),
        ) {
    getColleagues();
    getCustomFields();
  }

  factory EditProfileBloc.of(final BuildContext context) =>
      BlocProvider.of<EditProfileBloc>(context);

  void updateFirstName(final String firstName) {
    emit(
      state.rebuild(
        (final b) => b.firstName = firstName.trim().isEmpty ? null : firstName,
      ),
    );
  }

  void updateLastName(final String lastName) {
    emit(
      state.rebuild(
        (final b) => b.lastName = lastName.trim().isEmpty ? null : lastName,
      ),
    );
  }

  void updatePhoneNumber(final String phoneNumber) {
    emit(
      state.rebuild(
        (final b) =>
            b.phoneNumber = phoneNumber.trim().isEmpty ? null : phoneNumber,
      ),
    );
  }

  void updateJobTitle(final String jobTitle) {
    emit(
      state.rebuild(
        (final b) => b.jobTitle = jobTitle.trim().isEmpty ? null : jobTitle,
      ),
    );
  }

  void updateBio(final String bio) {
    emit(state.rebuild((final b) => b.bio = bio.trim().isEmpty ? null : bio));
  }

  void updateLinkedInUsername(final String linkedInUsername) {
    emit(
      state.rebuild(
        (final b) => b.linkedInUsername =
            linkedInUsername.trim().isEmpty ? null : linkedInUsername,
      ),
    );
  }

  void updateTwitterUsername(final String twitterUsername) {
    emit(
      state.rebuild(
        (final b) => b.twitterUsername =
            twitterUsername.trim().isEmpty ? null : twitterUsername,
      ),
    );
  }

  void updateFacebookUsername(final String facebookUsername) {
    emit(
      state.rebuild(
        (final b) => b.facebookUsername =
            facebookUsername.trim().isEmpty ? null : facebookUsername,
      ),
    );
  }

  void updateSkypeUsername(final String skypeUsername) {
    emit(
      state.rebuild(
        (final b) =>
            b.skypeUsername = skypeUsername.trim() == '' ? null : skypeUsername,
      ),
    );
  }

  void updateProfilePic(final PlatformFile profilePic) {
    emit(state.rebuild((final b) => b..profilePicture = profilePic));
  }

  void updateNumberCustomField(final int cfId, final String value) {
    dynamic dValue;
    try {
      if (value.contains('.')) {
        dValue = double.parse(value.replaceAll(' ', 'replace'));
      } else {
        dValue = int.parse(value.replaceAll(' ', 'replace'));
      }
    } catch (e) {
      dValue = null;
    }
    emit(
      state.rebuild((final b) {
        final cfvsMap =
            HashMap<String, Object>.from(state.customFieldsValues.asMap);
        if (dValue == null) {
          cfvsMap.remove('$cfvsMap');
        } else {
          cfvsMap['$cfId'] = dValue as Object;
        }
        b.customFieldsValues = JsonObject(cfvsMap);
      }),
    );
  }

  void updateStringCustomField(final int cfId, final String? value) {
    emit(
      state.rebuild(
        (final b) {
          final cfvsMap =
              HashMap<String, Object>.from(state.customFieldsValues.asMap);
          if (value == null || value.trim().isEmpty) {
            cfvsMap.remove('$cfId');
          } else {
            cfvsMap['$cfId'] = value;
          }
          b.customFieldsValues = JsonObject(cfvsMap);
        },
      ),
    );
  }

  void updateBoolCustomField({
    required final int cfId,
    required final bool value,
    final int? parentId,
  }) {
    final currentSelectedChildId =
        getSelectedCustomFieldChildIdOfParentId(parentId);

    emit(
      state.rebuild((final b) {
        final cfvsMap =
            HashMap<String, Object>.from(state.customFieldsValues.asMap);
        if (currentSelectedChildId != null) {
          cfvsMap.remove('$currentSelectedChildId');
        }
        if (!value) {
          cfvsMap.remove('$cfId');
        } else {
          cfvsMap['$cfId'] = value;
        }
        b.customFieldsValues = JsonObject(cfvsMap);
      }),
    );
  }

  Future<void> getColleagues() async {
    final profile = profileBloc.state!;
    if (profile.organizationId == null) {
      emit(state.rebuild((final b) => b.getColleaguesApi.data = BuiltList()));
      return;
    }
    emit(
      state.rebuild(
        (final b) => b.getColleaguesApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final users =
          await userService.getUsersByOrganizationId(profile.organizationId!);
      final colleagues = BuiltList<UserData>(
        users.where((final user) => user.id != profile.id),
      );
      emit(state.rebuild((final b) => b.getColleaguesApi.data = colleagues));
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.getColleaguesApi.error = metaData.message),
      );
    }
    emit(
      state.rebuild((final b) => b.getColleaguesApi.isApiInProgress = false),
    );
  }

  Future<void> getCustomFields() async {
    emit(
      state.rebuild(
        (final b) => b.getCustomFieldsApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final customFields = await customFieldService.getCustomFields();
      emit(
        state.rebuild((final b) => b.getCustomFieldsApi.data = customFields),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.getCustomFieldsApi.error = metaData.message,
        ),
      );
    }
    emit(
      state.rebuild((final b) => b.getCustomFieldsApi.isApiInProgress = false),
    );
  }

  Future<void> updateProfile() async {
    emit(
      state.rebuild(
        (final b) => b.updateProfileApi
          ..isApiInProgress = true
          ..error = null
          ..data = null,
      ),
    );
    try {
      final profile = await userService.updateProfile(
        customFieldValues: state.customFieldsValues.asMap.map<String, Object>(
          (final key, final value) => MapEntry(key as String, value as Object),
        ),
        phoneNumber: state.phoneNumber,
        jobTitle: state.jobTitle,
        bio: state.bio,
        linkedInUsername: state.linkedInUsername,
        twitterUsername: state.twitterUsername,
        facebookUsername: state.facebookUsername,
        skypeUsername: state.skypeUsername,
        profilePicture: state.profilePicture,
      );
      profileBloc.updateProfile(profile);
      emit(
        state.rebuild(
          (final b) => b
            ..profilePicture = null
            ..updateProfileApi.data = profile,
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.updateProfileApi.error = metaData.message),
      );
    }
    emit(
      state.rebuild((final b) => b.updateProfileApi.isApiInProgress = false),
    );
  }

  BuiltList<CustomFieldData>? getCustomFieldsByType(
    final CustomFieldType? type,
  ) {
    if (state.getCustomFieldsApi.data == null) {
      return null;
    }
    return BuiltList(
      state.getCustomFieldsApi.data!.where(
        (final cf) => cf.type == type,
      ),
    );
  }

  int? getSelectedCustomFieldChildIdOfParentId(final int? parentId) {
    if (parentId == null) {
      return null;
    }
    final customFields = state.getCustomFieldsApi.data;
    if (customFields == null) {
      return null;
    }
    final parent = customFields.firstWhereOrNull(
      (final cf) => cf.id == parentId,
    );
    if (parent == null) {
      return null;
    }
    int? selectedChildId;
    for (final child in parent.children!) {
      if (selectedChildId != null) {
        continue;
      }
      if (state.customFieldsValues.asMap.containsKey('${child.id}') &&
          state.customFieldsValues.asMap['${child.id}'] == true) {
        selectedChildId = child.id;
      }
    }
    return selectedChildId;
  }
}
