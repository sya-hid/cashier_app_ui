import 'package:cashier_app_ui/widgets/my_animation.dart';
import 'package:flutter/material.dart';

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final int durationInMs;
  final MyAnimation animatePosition;
  const FadeInAnimation(
      {super.key,
      required this.child,
      required this.durationInMs,
      required this.animatePosition});

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation> {
  bool? animate;
  @override
  void initState() {
    super.initState();
    changeAnimation();
  }

  Future changeAnimation() async {
    animate = false;
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) {
      setState(() {
        animate = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: widget.durationInMs),
      curve: Curves.easeInOut,
      top: animate!
          ? widget.animatePosition.topAfter
          : widget.animatePosition.topBefore,
      left: animate!
          ? widget.animatePosition.leftAfter
          : widget.animatePosition.leftBefore,
      child: widget.child,
    );
  }
}
