import 'package:flutter/material.dart';

/// High-performance entrance animation widget.
/// Once animation finishes, it drops Opacity & Transform layers completely,
/// allowing 60-120 FPS buttery smooth scrolling in Flutter Web and mobile.
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final int delayMs;
  final Duration duration;
  final Offset begin;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delayMs = 0,
    this.duration = const Duration(milliseconds: 240),
    this.begin = const Offset(0, 0.04),
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _anim.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _completed = true);
      }
    });

    final delay = widget.delayMs.clamp(0, 80);
    if (delay > 0) {
      Future.delayed(Duration(milliseconds: delay), () {
        if (mounted) _ctrl.forward();
      });
    } else {
      _ctrl.forward();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_completed) return widget.child;

    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        final val = _anim.value;
        return Opacity(
          opacity: val.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(widget.begin.dx * 16 * (1 - val), widget.begin.dy * 18 * (1 - val)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

Route<T> manaPageRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 220),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.03, 0), end: Offset.zero)
              .animate(curved),
          child: child,
        ),
      );
    },
  );
}
