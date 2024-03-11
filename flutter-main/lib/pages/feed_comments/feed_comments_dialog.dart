import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/data/feed_comment_data.dart';
import '../../models/states/api_state.dart';
import '../../widgets/close_icon.dart';
import '../../widgets/connection_information.dart';
import 'bloc/feed_comments_bloc.dart';
import 'bloc/feed_comments_state.dart';
import 'feed_comments_create_form.dart';
import 'feed_comments_list.dart';

class FeedCommentsDialog extends StatelessWidget {
  const FeedCommentsDialog._();

  static Future<bool> show(
    final BuildContext context, {
    required final int feedId,
  }) async {
    final bloc = FeedCommentsBloc(
      feedId: feedId,
    );
    await showDialog(
      context: context,
      builder: (final _) => BlocProvider(
        create: (final _) => bloc,
        child: const FeedCommentsDialog._(),
      ),
    );
    return bloc.state.isCommentAdded;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<FeedCommentsBloc, FeedCommentsState,
        ApiState<BuiltList<FeedCommentData>>>(
      selector: (final state) => state.getCommentsApi,
      builder: (final _, final getCommentsApi) => Dialog(
        insetPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: CloseIcon(
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
              Expanded(
                child: getCommentsApi.data == null
                    ? Center(
                        child: ConnectionInformation(
                          error: getCommentsApi.error,
                          onRetry: FeedCommentsBloc.of(context).getComments,
                        ),
                      )
                    : const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: FeedCommentsList(),
                          ),
                          Divider(),
                          Form(
                            child: FeedCommentsCreateForm(),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
