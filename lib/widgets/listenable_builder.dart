import 'package:flutter/material.dart';

class ListenableBuilder extends StatefulWidget {
  final Listenable listenable;
  final WidgetBuilder builder;

  const ListenableBuilder({
    required this.listenable,
    required this.builder,
  });

  @override
  State<ListenableBuilder> createState() => _ListenableBuilderState();
}

class _ListenableBuilderState extends State<ListenableBuilder> {
  @override
  void initState() {
    widget.listenable.addListener(_onListener);
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return widget.builder(context);
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_onListener);
    super.dispose();
  }

  void _onListener() {
    setState(() {});
  }
}
