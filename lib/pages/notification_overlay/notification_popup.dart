import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/colors.dart';
import '../../utils/color_utils.dart';
import '../../widgets/ink_well.dart';

const Curve _kResizeTimeCurve = Interval(0.4, 1.0, curve: Curves.ease);

class NotificationPopup extends StatefulWidget {
  final String id;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  // it is called even with on tap
  final VoidCallback onClose;

  NotificationPopup({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.onClose,
    this.onTap,
  }) : super(
          key: ValueKey(id),
        );

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup>
    with TickerProviderStateMixin {
  AnimationController? _resizeController;
  Animation<double>? _resizeAnimation;
  Size? _sizePriorToCollapse;
  Timer? _timer;

  @override
  void initState() {
    _startCloseTimer();
    super.initState();
  }

  @override
  void dispose() {
    _stopCloseTimer();
    _resizeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final child = Dismissible(
      key: ValueKey(widget.id),
      direction: getValueForScreenType(
        context: context,
        mobile: DismissDirection.horizontal,
        tablet: DismissDirection.startToEnd,
      ),
      onDismissed: (final _) {
        _stopCloseTimer();
        widget.onClose();
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Container(
            width: getValueForScreenType(
              context: context,
              mobile: double.infinity,
              tablet: 327,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(4.6, 32.7),
                  blurRadius: 84,
                ),
              ],
            ),
            child: Stack(
              children: [
                WCInkWell(
                  borderRadius: BorderRadius.circular(8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  onTap: _sizePriorToCollapse != null ? null : _onTap,
                  child: Row(
                    children: [
                      const _NotificationIcon(),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.subtitle,
                              style: const TextStyle(
                                fontSize: 13,
                                color: WCColors.grey_5d,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: CloseButton(
                    onPressed: _onClose,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (_sizePriorToCollapse == null) {
      return child;
    } else {
      return SizeTransition(
        sizeFactor: _resizeAnimation!,
        child: SizedBox(
          width: _sizePriorToCollapse!.width,
          height: _sizePriorToCollapse!.height,
          child: child,
        ),
      );
    }
  }

  void _onTap() {
    widget.onTap?.call();
    _onClose();
  }

  void _startCloseTimer() {
    _timer = Timer(
      const Duration(
        seconds: 5,
      ),
      _onClose,
    );
  }

  void _stopCloseTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _onClose() {
    _stopCloseTimer();
    _startResizeAnimation();
  }

  void _startResizeAnimation() {
    _resizeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(_handleResizeProgressChanged);
    _resizeController!.forward();
    setState(() {
      _sizePriorToCollapse = context.size;
      _resizeAnimation = _resizeController!
          .drive(
            CurveTween(
              curve: _kResizeTimeCurve,
            ),
          )
          .drive(
            Tween<double>(
              begin: 1.0,
              end: 0.0,
            ),
          );
    });
  }

  void _handleResizeProgressChanged() {
    if (_resizeController!.isCompleted) {
      widget.onClose();
    }
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon();

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 61,
      height: 61,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorUtils.lighten(
          Theme.of(context).primaryColor,
          0.9,
        ),
      ),
      child: Icon(
        Icons.notifications_rounded,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
