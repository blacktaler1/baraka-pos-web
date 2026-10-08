import 'dart:async';

import 'package:flutter/material.dart';

import 'count_down_widget.dart';
import 'reming_time_widget.dart';

class CountdownTimer extends StatefulWidget {
  final String limit;
  const CountdownTimer({super.key, required this.limit});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration remaining;
  Timer? timer; // Timer nullable bo'lgani yaxshi

  @override
  void initState() {
    super.initState();
    remaining = calculateRemaining(widget.limit);

    if (remaining.inSeconds > 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (mounted) {
          setState(() {
            if (remaining.inSeconds <= 0) {
              t.cancel();
            } else {
              remaining = remaining - const Duration(seconds: 1);
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Duration calculateRemaining(String limit) {
    final end = DateTime.tryParse(limit); // Xavfsiz parse
    if (end == null) return Duration.zero;

    final now = DateTime.now();
    final diff = end.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }

  @override
  Widget build(BuildContext context) {
    final t = RemainingTime.fromDuration(remaining);
    return CountdownWidget(
      days: t.days,
      hours: t.hours,
      minutes: t.minutes,
      seconds: t.seconds,
    );
  }
}
