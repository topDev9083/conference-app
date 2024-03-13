import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/colors.dart';
import '../../../extensions/date_time.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/feed_data.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/disable_fade.dart';
import '../../../widgets/icon_label_button.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/time_zone_bloc_builder.dart';
import '../../../widgets/trn_text.dart';
import '../../feed_comments/feed_comments_dialog.dart';
import '../../image_view/image_view_dialog.dart';
import 'bloc/feeds_bloc.dart';
import 'bloc/feeds_state.dart';

class FeedItem extends StatelessWidget {
  final FeedData feed;

  const FeedItem(this.feed);

  @override
  Widget build(final BuildContext context) {
    final bloc = FeedsBloc.of(context);
    final padding = getValueForScreenType<double>(
      context: context,
      mobile: 16,
      tablet: 32,
    );
    return BlocSelector<FeedsBloc, FeedsState, ApiState<void>>(
      selector: (final state) =>
          state.likeUnlikeFeedApi[feed.id] ?? ApiState<void>(),
      builder: (final _, final likeUnlikeFeedApi) =>
          BlocSelector<FeedsBloc, FeedsState, ApiState<void>>(
        selector: (final state) =>
            state.watchSnoozeFeedApi[feed.id] ?? ApiState<void>(),
        builder: (final _, final watchSnoozeFeedApi) => Padding(
          padding: EdgeInsets.only(
            bottom: padding,
            left: padding,
            right: padding,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 32),
                      Expanded(
                        child: _UserInfo(
                          feed,
                        ),
                      ),
                      PopupMenuButton<int>(
                        position: PopupMenuPosition.under,
                        offset: const Offset(-20, -3),
                        onSelected: (final _) => bloc.watchSnoozeFeed(
                          feed.id,
                          !feed.isWatching,
                        ),
                        itemBuilder: (final _) => [
                          PopupMenuItem<int>(
                            value: 0,
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 5,
                              bottom: 5,
                              right: 2,
                            ),
                            height: 0,
                            enabled: !watchSnoozeFeedApi.isApiInProgress,
                            child: DisableFade(
                              disable: watchSnoozeFeedApi.isApiInProgress,
                              child: TrnText(
                                feed.isWatching
                                    ? TranslationKeys.Feeds_Snooze_Notifications
                                    : TranslationKeys.Feeds_Watch_Feed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        if (feed.text != null) ...[
                          const SizedBox(height: 8),
                          Text(feed.text!),
                        ],
                        if (feed.imageUrl != null) ...[
                          const SizedBox(height: 8),
                          WCInkWell(
                            onTap: () => ImageViewDialog.show(
                              context,
                              image: feed.imageUrl,
                            ),
                            child: WCImage(
                              image: feed.imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              height: 320,
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        Transform.translate(
                          offset: const Offset(-14, 0),
                          child: Row(
                            children: [
                              DisableFade(
                                disable: likeUnlikeFeedApi.isApiInProgress,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 100,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: IconLabelButton(
                                      labelKey: feed.isLiked
                                          ? TranslationKeys.Feeds_Unlike
                                          : TranslationKeys.Feeds_Like,
                                      iconAsset: 'ic_heart.png',
                                      iconColor:
                                          feed.isLiked ? WCColors.red_ff : null,
                                      onTap: likeUnlikeFeedApi.isApiInProgress
                                          ? null
                                          : () => bloc.likeOrUnlikeFeed(
                                                feed.id,
                                                !feed.isLiked,
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                              IconLabelButton(
                                labelKey: TranslationKeys.Feeds_Comment,
                                icon: Icons.comment_rounded,
                                onTap: () => _showComments(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                translate(
                                  context,
                                  feed.isLiked
                                      ? TranslationKeys
                                          .Feeds_You_And_Other_Likes_Count_Count_0
                                      : TranslationKeys
                                          .Feeds_Other_Likes_Count_Count_0,
                                  pluralValue:
                                      feed.likesCount - (feed.isLiked ? 1 : 0),
                                )!,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(12, 0),
                              child: WCInkWell(
                                onTap: () => _showComments(context),
                                borderRadius: BorderRadius.circular(999),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Text(
                                  translate(
                                    context,
                                    TranslationKeys
                                        .Feeds_Comments_Count_Count_0,
                                    pluralValue: feed.commentsCount,
                                  )!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Future<void> _showComments(final BuildContext context) async {
    final bloc = FeedsBloc.of(context);
    final isCommentAdded = await FeedCommentsDialog.show(
      context,
      feedId: feed.id,
    );
    if (isCommentAdded) {
      bloc.markFeedAsWatching(feed.id);
    }
  }
}

class _UserInfo extends StatelessWidget {
  final FeedData feed;

  const _UserInfo(this.feed);

  @override
  Widget build(final BuildContext context) {
    final user = feed.createdByUser;
    return Row(
      children: [
        UserAvatar(
          size: 35,
          profilePicture: user?.profilePicture,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                user?.fullName ?? 'Administrator',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TimeZoneBlocBuilder(
                builder: (final tz) => Text(
                  feed.createdOn.timeAgo(
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
    );
  }
}
