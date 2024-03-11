import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/profile_bloc.dart';
import '../../../../models/data/country_data.dart';
import '../../../../models/data/organization_data.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/organization_service.dart';
import '../../../../widgets/cubit.dart';
import 'edit_organization_state.dart';

class EditOrganizationBloc extends WCCubit<EditOrganizationState> {
  final ProfileBloc profileBloc;

  EditOrganizationBloc({
    required this.profileBloc,
    required final OrganizationData? organization,
  }) : super(
          EditOrganizationState(
            (final b) => b.organization.replace(
              organization ?? OrganizationData((final bOrg) => bOrg.name = ''),
            ),
          ),
        );

  factory EditOrganizationBloc.of(final BuildContext context) =>
      BlocProvider.of<EditOrganizationBloc>(context);

  void updateName(final String name) {
    emit(
      state.rebuild(
        (final b) => b.organization.name = name,
      ),
    );
  }

  void updatePhoneNumber(final String phoneNumber) {
    emit(
      state.rebuild(
        (final b) => b.organization.phoneNumber =
            phoneNumber.isEmpty ? null : phoneNumber,
      ),
    );
  }

  void updateWebsite(final String website) {
    emit(
      state.rebuild(
        (final b) => b.organization.website = website.isEmpty ? null : website,
      ),
    );
  }

  void updateEmail(final String email) {
    emit(
      state.rebuild(
        (final b) => b.organization.email = email.isEmpty ? null : email,
      ),
    );
  }

  void updateAddress(final String address) {
    emit(
      state.rebuild(
        (final b) => b.organization.address = address.isEmpty ? null : address,
      ),
    );
  }

  void updateCity(final String city) {
    emit(
      state.rebuild(
        (final b) => b.organization.city = city.isEmpty ? null : city,
      ),
    );
  }

  void updateState(final String xState) {
    emit(
      state.rebuild(
        (final b) => b.organization.state = xState.isEmpty ? null : xState,
      ),
    );
  }

  void updateZipCode(final String zipCode) {
    emit(
      state.rebuild(
        (final b) => b.organization.zipCode = zipCode.isEmpty ? null : zipCode,
      ),
    );
  }

  void updateProfile(final String profile) {
    emit(
      state.rebuild(
        (final b) => b.organization.profile = profile.isEmpty ? null : profile,
      ),
    );
  }

  void updateLogo(final PlatformFile? logo) {
    emit(
      state.rebuild(
        (final b) => b.logo = logo,
      ),
    );
  }

  void updateCountry(final CountryData? country) {
    emit(
      state.rebuild(
        (final b) => b.organization
          ..countryId = country?.id
          ..country = country?.toBuilder(),
      ),
    );
  }

  Future<void> updateOrganization() async {
    emit(
      state.rebuild(
        (final b) => b.updateOrganizationApi
          ..isApiInProgress = true
          ..data = null
          ..error = null,
      ),
    );
    try {
      final organization = await organizationService.updateOrganization(
        name: state.organization.name,
        phoneNumber: state.organization.phoneNumber,
        website: state.organization.website,
        email: state.organization.email,
        address: state.organization.address,
        city: state.organization.city,
        state: state.organization.state,
        zipCode: state.organization.zipCode,
        profile: state.organization.profile,
        countryId: state.organization.countryId,
        logo: state.logo,
      );
      emit(
        state.rebuild(
          (final b) => b
            ..updateOrganizationApi.data = organization
            ..organization.replace(organization)
            ..logo = null,
        ),
      );
      profileBloc.updateOrganization(organization);
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.updateOrganizationApi.error = metaData.message,
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.updateOrganizationApi.isApiInProgress = false,
      ),
    );
  }
}
