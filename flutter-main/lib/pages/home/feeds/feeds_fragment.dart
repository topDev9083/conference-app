import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../models/data/feed_data.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/bloc_listener.dart';
import '../../../widgets/connection_information.dart';
import 'bloc/feeds_bloc.dart';
import 'bloc/feeds_state.dart';
import 'feeds_create_form.dart';
import 'feeds_sliver_list.dart';

class FeedsFragment extends StatelessWidget {
  const FeedsFragment();

  @override
  Widget build(final BuildContext context) {
    final spacing = getValueForScreenType<double>(
      context: context,
      mobile: 16,
      tablet: 32,
    );
    final width = getValueForScreenType<double>(
      context: context,
      mobile: double.infinity,
      tablet: 700,
    );
    return BlocProvider(
      create: (final _) => FeedsBloc(),
      child: MultiBlocListener(
        listeners: [
          ErrorBlocListener<FeedsBloc, FeedsState>(
            errorWhen: (final state) => state.createPostApi.error,
          ),
          ErrorsMapBlocListener<FeedsBloc, FeedsState, int, void>(
            context: context,
            errorWhen: (final state) => state.watchSnoozeFeedApi,
          ),
        ],
        child:
            BlocSelector<FeedsBloc, FeedsState, ApiState<BuiltList<FeedData>>>(
          selector: (final state) => state.getFeedsApi,
          builder: (final context, final getFeedsApi) =>
              getFeedsApi.data != null
                  ? CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: spacing,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Form(
                            child: Center(
                              child: SizedBox(
                                width: width,
                                child: const FeedsCreateForm(),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: spacing,
                          ),
                        ),
                        FeedsSliverList(
                          width: width,
                        ),
                      ],
                    )
                  : Center(
                      child: ConnectionInformation(
                        error: getFeedsApi.error,
                        onRetry: FeedsBloc.of(context).getFeeds,
                      ),
                    ),
        ),
      ),
    );
  }
}
