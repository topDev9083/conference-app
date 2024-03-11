import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/data/feed_data.dart';
import 'bloc/feeds_bloc.dart';
import 'bloc/feeds_state.dart';
import 'feed_item.dart';

class FeedsSliverList extends StatelessWidget {
  final double width;

  const FeedsSliverList({
    required this.width,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<FeedsBloc, FeedsState, BuiltList<FeedData>>(
      selector: (final state) => state.getFeedsApi.data!,
      builder: (final _, final feeds) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (final context, final index) => Center(
            key: ValueKey(feeds[index].id),
            child: SizedBox(
              width: width,
              child: FeedItem(feeds[index]),
            ),
          ),
          childCount: feeds.length,
        ),
      ),
    );
  }
}
