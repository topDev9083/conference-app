import 'package:flutter/material.dart';

typedef ValueChangeBuilder<T> = void Function(BuildContext context, T value);

class ValueChangeNotifier<T> extends StatefulWidget {
  final T value;
  final Widget child;
  final ValueChangeBuilder<T> onChanged;

  const ValueChangeNotifier({
    required this.value,
    required this.child,
    required this.onChanged,
  });

  @override
  _ValueChangeNotifierState<T> createState() => _ValueChangeNotifierState<T>();
}

class _ValueChangeNotifierState<T> extends State<ValueChangeNotifier<T>> {
  @override
  void didUpdateWidget(covariant final ValueChangeNotifier<T> oldWidget) {
    if (oldWidget.value != widget.value) {
      widget.onChanged(context, widget.value);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) {
    return widget.child;
  }
}
