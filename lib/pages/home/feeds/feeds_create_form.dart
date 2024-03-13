import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../utils/bottom_sheet_utils.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/icon_label_button.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/trn_text.dart';
import 'bloc/feeds_bloc.dart';
import 'bloc/feeds_state.dart';

class FeedsCreateForm extends StatelessWidget {
  const FeedsCreateForm();

  @override
  Widget build(final BuildContext context) {
    final bloc = FeedsBloc.of(context);
    return BlocBuilder<FeedsBloc, FeedsState>(
      builder: (final _, final state) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
            context: context,
            mobile: 16,
            tablet: 32,
          ),
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(
              getValueForScreenType(
                context: context,
                mobile: 16,
                tablet: 32,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TrnText(
                  TranslationKeys.Feeds_Create_Feed,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: null,
                  minLines: 3,
                  decoration: InputDecoration(
                    hintText: translate(
                      context,
                      TranslationKeys.Feeds_Create_Feed_Hint,
                    )!,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  enabled: !state.createPostApi.isApiInProgress,
                  onChanged: bloc.updateCreateFeedText,
                ),
                if (state.createPostImage != null) ...[
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      Center(
                        child: WCImage(
                          image: state.createPostImage?.path,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: WCInkWell(
                            onTap: state.createPostApi.isApiInProgress
                                ? null
                                : () => bloc.updateCreateFeedImage(null),
                            isCircle: true,
                            isDark: true,
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.translate(
                      offset: const Offset(-14, 0),
                      child: IconLabelButton(
                        onTap: state.createPostApi.isApiInProgress
                            ? null
                            : () => _onSelectImage(context),
                        icon: Icons.image,
                        labelKey: TranslationKeys.Feeds_Photo,
                      ),
                    ),
                    WCElevatedButton(
                      translate(
                        context,
                        TranslationKeys.Feeds_Post,
                      )!,
                      showLoader: state.createPostApi.isApiInProgress,
                      onTap: () => _onPost(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSelectImage(final BuildContext context) async {
    final bloc = FeedsBloc.of(context);
    final int? selectedOption;
    if (kIsWeb) {
      selectedOption = 1;
    } else {
      selectedOption = await BottomSheetUtils.showOptions(
        context,
        options: [
          BottomSheetOption(
            TranslationKeys.General_Camera,
          ),
          BottomSheetOption(
            TranslationKeys.General_Gallery,
          ),
        ],
      );
    }
    if (selectedOption == null) {
      return;
    }
    final imageXFile = await ImagePicker().pickImage(
      source: selectedOption == 0 ? ImageSource.camera : ImageSource.gallery,
    );
    if (imageXFile == null) {
      return;
    }
    bloc.updateCreateFeedImage(imageXFile);
  }

  Future<void> _onPost(final BuildContext context) async {
    final form = Form.of(context);
    final bloc = FeedsBloc.of(context);
    final state = bloc.state;
    if (state.createPostText.trim().isEmpty && state.createPostImage == null) {
      return;
    }
    final isSuccess = await bloc.createFeed();
    if (isSuccess) {
      await Future.delayed(Duration.zero);
      bloc.updateCreateFeedImage(null);
      bloc.updateCreateFeedText("");
      form.reset();
    }
  }
}
