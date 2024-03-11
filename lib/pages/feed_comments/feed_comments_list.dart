import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../extensions/date_time.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../models/data/feed_comment_data.dart';
import '../../widgets/avatar.dart';
import '../../widgets/time_zone_bloc_builder.dart';
import 'bloc/feed_comments_bloc.dart';
import 'bloc/feed_comments_state.dart';

class FeedCommentsList extends StatelessWidget {
  const FeedCommentsList();

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<FeedCommentsBloc, FeedCommentsState,
        BuiltList<FeedCommentData>>(
      selector: (final state) => state.getCommentsApi.data!,
      builder: (final _, final comments) => ListView.separated(
        itemBuilder: (final _, final index) => _CommentItem(comments[index]),
        separatorBuilder: (final _, final __) => const Divider(),
        itemCount: comments.length,
        reverse: true,
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  final FeedCommentData comment;

  const _CommentItem(this.comment);

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            profilePicture: comment.createdByUser?.profilePicture,
            size: 30,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: comment.createdByUser?.fullName ??
                            translate(
                              context,
                              TranslationKeys.Feeds_Administrator,
                            ),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' ${comment.text}',
                      ),
                    ],
                  ),
                ),
                TimeZoneBlocBuilder(
                  builder: (final tz) => Text(
                    comment.createdOn.timeAgo(
                      timeZone: tz,
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      color: WCColors.grey_9f,
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
}
