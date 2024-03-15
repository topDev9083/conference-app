import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../models/enums/message_type.dart';
import '../../../../widgets/progress_indicator.dart';
import '../../../../widgets/text_field_controller.dart';
import 'bloc/thread_detail_bloc.dart';
import 'bloc/thread_detail_state.dart';

class SendMessageField extends StatelessWidget {
  const SendMessageField();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ThreadDetailBloc, ThreadDetailState>(
      builder: (final _, final state) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
            context: context,
            mobile: 20,
            tablet: 46,
          ),
        ),
        child: TextFieldController(
          builder: (final controller) => TextField(
            enabled: !state.attachmentApi.isApiInProgress,
            controller: controller,
            onEditingComplete: () => _sendMessage(context, controller),
            textInputAction: TextInputAction.send,
            onChanged: ThreadDetailBloc.of(context).updateMessageText,
            decoration: InputDecoration(
              isDense: true,
              hintText: translate(
                context,
                TranslationKeys.Messages_Type_Your_Message,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 15,
              ),
              suffixIcon: () {
                if (state.attachmentApi.isApiInProgress) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 16,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: WCProgressIndicator.small(),
                    ),
                  );
                } else if (state.message.isEmpty) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image),
                        color: Theme.of(context).primaryColor,
                        onPressed: () => _sendFile(context, MessageType.image),
                      ),
                      IconButton(
                        icon: const Icon(Icons.attach_file),
                        color: Theme.of(context).primaryColor,
                        onPressed: () => _sendFile(context, MessageType.file),
                      ),
                    ],
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.send_rounded),
                    onPressed: () => _sendMessage(context, controller),
                    color: Theme.of(context).primaryColor,
                  );
                }
              }(),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(500),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage(
    final BuildContext context,
    final TextEditingController controller,
  ) {
    ThreadDetailBloc.of(context).sendMessage();
    controller.clear();
  }

  Future<void> _sendFile(
    final BuildContext context,
    final MessageType type,
  ) async {
    final bloc = ThreadDetailBloc.of(context);
    final result = await FilePicker.platform.pickFiles(
      type: type == MessageType.image ? FileType.image : FileType.any,
    );
    if (result == null || result.files.isEmpty) {
      return;
    }
    await bloc.sendAttachment(
      file: result.files.first,
      type: type,
    );
  }
}
