import 'package:flutter/material.dart';

class AutomaticKeepAliveClient extends StatefulWidget {
  final Widget child;

  const AutomaticKeepAliveClient({
    required this.child,
  });

  @override
  _AutomaticKeepAliveClientState createState() =>
      _AutomaticKeepAliveClientState();
}

class _AutomaticKeepAliveClientState extends State<AutomaticKeepAliveClient>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(final BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
