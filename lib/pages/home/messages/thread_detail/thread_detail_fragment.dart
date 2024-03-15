import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home_drawer_bloc.dart';
import '../../../../widgets/dialogs.dart';
import 'bloc/thread_detail_bloc.dart';
import 'bloc/thread_detail_state.dart';
import 'thread_detail_container.dart';

class ThreadDetailFragment extends StatelessWidget {
  final int userId;

  const ThreadDetailFragment(this.userId);

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => ThreadDetailBloc(
        userId,
        homeDrawerBloc: HomeDrawerBloc.of(context),
      ),
      child: BlocListener<ThreadDetailBloc, ThreadDetailState>(
        listenWhen: (final prev, final next) =>
            prev.attachmentApi.error == null &&
            next.attachmentApi.error != null,
        listener: (final _, final state) => WCDialog.showError(
          context,
          subtitle: state.attachmentApi.error,
        ),
        child: Container(
          color: Colors.white,
          child: const ThreadDetailContainer(),
        ),
      ),
    );
  }
}
