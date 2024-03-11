import 'package:flutter/material.dart';

class MeetingStatusEvents {
  final VoidCallback? pendingMe;
  final VoidCallback? rescheduledMe;
  final VoidCallback? acceptedMe;
  final VoidCallback? postPendingMe;
  final VoidCallback? postRescheduledMe;
  final VoidCallback? rejectedMe;
  final VoidCallback? cancelledMe;
  final VoidCallback? postRejectedMe;
  final VoidCallback? postCancelledMe;

  final VoidCallback? pendingHim;
  final VoidCallback? rescheduledHim;
  final VoidCallback? acceptedHim;
  final VoidCallback? postPendingHim;
  final VoidCallback? postRescheduledHim;
  final VoidCallback? rejectedHim;
  final VoidCallback? cancelledHim;
  final VoidCallback? postRejectedHim;
  final VoidCallback? postCancelledHim;

  MeetingStatusEvents({
    required this.pendingMe,
    required this.pendingHim,
    required this.rescheduledMe,
    required this.rescheduledHim,
    required this.acceptedMe,
    required this.acceptedHim,
    required this.postPendingMe,
    required this.postPendingHim,
    required this.postRescheduledMe,
    required this.postRescheduledHim,
    required this.cancelledMe,
    required this.cancelledHim,
    required this.rejectedMe,
    required this.rejectedHim,
    required this.postCancelledMe,
    required this.postCancelledHim,
    required this.postRejectedMe,
    required this.postRejectedHim,
  });
}
