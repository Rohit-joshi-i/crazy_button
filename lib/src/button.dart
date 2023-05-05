import 'package:flutter/material.dart';
import 'dart:math' as math;

var _constantShake = const Duration(seconds: 3);

///
/// Button to give shake animation to the flutter widget
/// Example :
///   CrazyButton(
///                 infiniteShake: true,
///                 child: Container(
///                     height: 60,
///                     width: 100,
///                     decoration: BoxDecoration(
///                         color: Colors.greenAccent,
///                         borderRadius: BorderRadius.circular(10)),
///                     child: const Center(
///                         child: Icon(
///                       Icons.ac_unit,
///                     ))),
///               ),
///
class CrazyButton extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final double? repetitions;
  final bool infiniteShake;
  const CrazyButton(
      {required this.child,
      this.duration,
      this.repetitions = 1,
      this.infiniteShake = false,
      Key? key})
      : assert(repetitions == null || !infiniteShake,
            'Cannot have both repetitions and infinite shake without values'),
        super(key: key);

  @override
  State<CrazyButton> createState() => _CrazyButtonState();
}

class _CrazyButtonState extends State<CrazyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _repetitions = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? _constantShake,
    );

    ///
    ///
    ///Different tween animations to change positions
    ///
    ///
    _animation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0 * math.pi / 180,
          end: -25 * math.pi / 180,
        ),
        weight: .07,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: -25 * math.pi / 180,
          end: 15 * math.pi / 180,
        ),
        weight: .08,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 15 * math.pi / 180,
          end: -10 * math.pi / 180,
        ),
        weight: .07,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: -10 * math.pi / 180,
          end: 10 * math.pi / 180,
        ),
        weight: .08,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 10 * math.pi / 180,
          end: -10 * math.pi / 180,
        ),
        weight: .05,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: -10 * math.pi / 180,
          end: 6 * math.pi / 180,
        ),
        weight: .05,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 6 * math.pi / 180,
          end: -4 * math.pi / 180,
        ),
        weight: .05,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: -4 * math.pi / 180,
          end: 0,
        ),
        weight: .4,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    ));
    if (!widget.infiniteShake) {
      _controller.addListener(_onAnimationUpdate);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///
  /// Animated builder to build transformative UI
  ///
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _animation.value,
          child: child,
        );
      },
      child: InkWell(
        onTap: _startShake,
        child: widget.child,
      ),
    );
  }

  ///
  /// Starting the button wiggle on tap
  ///
  void _startShake() {
    if (widget.infiniteShake) {
      _controller.repeat();
    } else {
      if (_controller.isCompleted) {
        _controller.reset();
        _repetitions = 0;
      } else {
        _controller.forward();
      }
    }
  }

  ///
  ///
  ///On Animation completion stop animation
  ///
  ///
  void _onAnimationUpdate() {
    if (_controller.status == AnimationStatus.completed) {
      _repetitions++;
      if (_repetitions >= (widget.repetitions ?? 0)) {
        _controller.stop();
      } else {
        _controller.reverse();
      }
    } else if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }
}
