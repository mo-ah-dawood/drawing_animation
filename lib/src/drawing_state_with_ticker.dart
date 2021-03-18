import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'abstract_drawing_state.dart';

/// A state implementation with an implemented animation controller to simplify the animation process
class AnimatedDrawingWithTickerState extends AbstractAnimatedDrawingState
    with SingleTickerProviderStateMixin {
  AnimatedDrawingWithTickerState() : super() {
    onFinishAnimation = () {
      if (!onFinishEvoked) {
        onFinishEvoked = true;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          onFinishAnimationDefault();
        });
        //Animation is completed when last frame is painted not when animation controller is finished
        if (animation.status == AnimationStatus.dismissed ||
            animation.status == AnimationStatus.completed) {
          finished = true;
        }
      }
    };
  }

  //Manage state
  bool paused = false;
  bool finished = true;

  @override
  Widget build(BuildContext context) {
    return createCustomPaint(context);
  }

//
}
