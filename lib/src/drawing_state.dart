import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'abstract_drawing_state.dart';
import 'drawing_widget.dart';

/// A state implementation which allows controlling the animation through an animation controller when provided.
class AnimatedDrawingState extends AbstractAnimatedDrawingState {
  AnimatedDrawingState() : super() {
    onFinishAnimation = () {
      if (!onFinishEvoked) {
        onFinishEvoked = true;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          onFinishAnimationDefault();
        });
      }
    };
  }

  @override
  void initState() {
    super.initState();
    animation = widget.animation;
    addListenersToAnimationController();
  }

  @override
  void didUpdateWidget(AnimatedDrawing oldWidget) {
    super.didUpdateWidget(oldWidget);
    animation = widget.animation;
  }

  @override
  Widget build(BuildContext context) {
    return createCustomPaint(context);
  }
}
