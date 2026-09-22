import 'package:flutter/material.dart';

class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    super.key,
    required this.animation,
    required this.child,
    this.begin = 0,
    this.end = 1,
    this.offset = const Offset(0, 0.12),
    this.curve = Curves.easeOutCubic,
  });

  final Animation<double> animation;
  final Widget child;
  final double begin;
  final double end;
  final Offset offset;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: animation, curve: Interval(begin, end, curve: curve),);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(begin: offset, end: Offset.zero).animate(curved),
        child: child,
      ),
    );
  }
}
