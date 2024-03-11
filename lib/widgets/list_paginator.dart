import 'package:flutter/material.dart';

import 'connection_information.dart';

class ListPaginator extends StatefulWidget {
  final String? error;
  final VoidCallback onLoad;

  const ListPaginator({
    required this.error,
    required this.onLoad,
  });

  @override
  _ListPaginatorState createState() => _ListPaginatorState();
}

class _ListPaginatorState extends State<ListPaginator>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.onLoad();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    super.build(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: ConnectionInformation(
          error: widget.error,
          onRetry: widget.onLoad,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
