import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'abstract_drawing_state.dart';
import 'drawing_widget.dart';

/// A state implementation with an implemented animation controller to simplify the animation process
class AnimatedDrawingWithTickerState extends AbstractAnimatedDrawingState
    with SingleTickerProviderStateMixin {
  AnimatedDrawingWithTickerState() : super() {
    this.onFinishAnimation = () {
      if (!this.onFinishEvoked) {
        this.onFinishEvoked = true;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          this.onFinishAnimationDefault();
        });
        //Animation is completed when last frame is painted not when animation controller is finished
        if (this.animation.status == AnimationStatus.dismissed ||
            this.animation.status == AnimationStatus.completed) {
          this.finished = true;
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
