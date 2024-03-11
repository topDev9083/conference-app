import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/event_code_bloc.dart';
import '../../core/colors.dart';
import '../../core/configs.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/image.dart';
import '../../widgets/trn_text.dart';
import 'bloc/select_event_code_bloc.dart';
import 'bloc/select_event_code_state.dart';
import 'event_code_input_formatter.dart';

class SelectEventCodePage extends StatelessWidget {
  const SelectEventCodePage();

  @override
  Widget build(final BuildContext context) {
    const hintStyle = TextStyle(
      fontSize: 17,
      color: WCColors.grey_9f,
    );
    return BlocProvider(
      create: (final _) => SelectEventCodeBloc(
        eventBloc: EventBloc.of(context),
        eventCodeBloc: EventCodeBloc.of(context),
      ),
      child: BlocBuilder<SelectEventCodeBloc, SelectEventCodeState>(
        builder: (final context, final state) => Form(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  const SizedBox(height: 32),
                  const Center(
                    child: WCImage(
                      image: 'logo_and_text.png',
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 132),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const TrnText(
                          TranslationKeys.Select_Event_Code_Event_Url,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  state.eventCodeFocusNode.requestFocus(),
                              child: const Text(
                                'https://',
                                style: hintStyle,
                              ),
                            ),
                            IntrinsicWidth(
                              child: TextFormField(
                                enabled: !state.getEventApi.isApiInProgress,
                                focusNode: state.eventCodeFocusNode,
                                onChanged: SelectEventCodeBloc.of(context)
                                    .updateEventCode,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                  EventCodeInputFormatter(),
                                ],
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: translate(
                                    context,
                                    TranslationKeys
                                        .Select_Event_Code_Your_Event_Code,
                                  ),
                                  hintStyle: hintStyle,
                                  border: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  state.eventCodeFocusNode.requestFocus(),
                              child: Text(
                                '.${config.deepLink}',
                                style: hintStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TrnText(
                          state.getEventApi.error ??
                              TranslationKeys.Select_Event_Code_Hint_Subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: state.getEventApi.error == null
                                ? WCColors.grey_69
                                : WCColors.red_ff,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 16,
                      end: 16,
                      bottom: 16,
                    ),
                    child: WCElevatedButton(
                      translate(
                        context,
                        TranslationKeys.General_Next,
                      )!,
                      showLoader: state.getEventApi.isApiInProgress,
                      onTap: !state.isEventCodeValid
                          ? null
                          : () => _onNext(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onNext(final BuildContext context) {
    SelectEventCodeBloc.of(context).getEventByCode();
  }
}
