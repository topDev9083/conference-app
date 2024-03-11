import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/trn_text.dart';
import 'bloc/edit_organization_bloc.dart';
import 'bloc/edit_organization_state.dart';

class EditOrganizationLogo extends StatelessWidget {
  const EditOrganizationLogo();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<EditOrganizationBloc, EditOrganizationState>(
      builder: (final _, final state) => Column(
        children: [
          const SizedBox(height: 20),
          const TrnText(
            TranslationKeys.Edit_Organization_Organization_Logo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                WCInkWell(
                  isDark: true,
                  isOverLay: true,
                  onTap: state.updateOrganizationApi.isApiInProgress
                      ? null
                      : () => _onPickLogo(context),
                  child: OrganizationAvatar(
                    size: 120,
                    logoUrl: state.organization.logo,
                    file: state.logo,
                  ),
                ),
                PositionedDirectional(
                  bottom: -6,
                  end: -6,
                  child: WCInkWell(
                    isDark: true,
                    isOverLay: true,
                    isCircle: true,
                    onTap: state.updateOrganizationApi.isApiInProgress
                        ? null
                        : () => _onPickLogo(context),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onPickLogo(final BuildContext context) async {
    final bloc = EditOrganizationBloc.of(context);
    final imageFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (imageFiles == null || imageFiles.count == 0) {
      return;
    }
    final imageFile = imageFiles.files.first;
    bloc.updateLogo(imageFile);
  }
}
