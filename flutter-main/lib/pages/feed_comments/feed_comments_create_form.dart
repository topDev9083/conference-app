import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../models/states/api_state.dart';
import '../../widgets/progress_indicator.dart';
import 'bloc/feed_comments_bloc.dart';
import 'bloc/feed_comments_state.dart';

class FeedCommentsCreateForm extends StatelessWidget {
  const FeedCommentsCreateForm();

  @override
  Widget build(final BuildContext context) {
    const inputBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
    );
    final bloc = FeedCommentsBloc.of(context);
    return BlocSelector<FeedCommentsBloc, FeedCommentsState, ApiState<void>>(
      selector: (final state) => state.createCommentApi,
      builder: (final _, final createCommentApi) => Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 12,
          bottom: 4,
          top: 4,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsetsDirectional.only(
                    start: 8,
                  ),
                  filled: true,
                  fillColor: WCColors.grey_f2,
                  hintText: translate(
                    context,
                    TranslationKeys.Feed_Comments_Create_Hint,
                  ),
                  border: inputBorder,
                  disabledBorder: inputBorder,
                  enabledBorder: inputBorder,
                  errorBorder: inputBorder,
                  focusedBorder: inputBorder,
                  focusedErrorBorder: inputBorder,
                ),
                maxLines: 5,
                minLines: 1,
                enabled: !createCommentApi.isApiInProgress,
                onChanged: bloc.updateCommentText,
              ),
            ),
            createCommentApi.isApiInProgress
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: WCProgressIndicator.small(
                      size: 18,
                    ),
                  )
                : IconButton(
                    onPressed: createCommentApi.isApiInProgress
                        ? null
                        : () => _onPostComment(context),
                    icon: Icon(
                      Icons.send_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPostComment(final BuildContext context) async {
    final bloc = FeedCommentsBloc.of(context);
    final form = Form.of(context);

    final state = bloc.state;
    if (state.commentText.trim().isEmpty) {
      return;
    }
    final isSuccess = await bloc.postComment();
    if (!isSuccess) {
      return;
    }
    bloc.updateCommentText("");
    await Future.delayed(Duration.zero);
    form.reset();
  }
}
