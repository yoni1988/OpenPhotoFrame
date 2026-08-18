import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// All transition effects that can be used when switching photos.
///
/// The persisted config stores the [id] string, so ids must stay stable.
enum TransitionEffect {
  fade('fade'),
  slideRight('slide_right'),
  slideLeft('slide_left'),
  slideUp('slide_up'),
  slideDown('slide_down'),
  zoomIn('zoom_in'),
  zoomOut('zoom_out'),
  rotate('rotate'),
  flip('flip'),
  blur('blur'),
  /// Picks a random concrete effect for every single transition.
  random('random');

  const TransitionEffect(this.id);

  final String id;

  /// Effects that actually render something (i.e. everything but [random]).
  static const List<TransitionEffect> concrete = [
    fade,
    slideRight,
    slideLeft,
    slideUp,
    slideDown,
    zoomIn,
    zoomOut,
    rotate,
    flip,
    blur,
  ];

  static TransitionEffect fromId(String? id) {
    for (final effect in TransitionEffect.values) {
      if (effect.id == id) return effect;
    }
    return TransitionEffect.fade;
  }

  /// Resolves [random] to a concrete effect; other values are returned as-is.
  TransitionEffect resolve([math.Random? rng]) {
    if (this != TransitionEffect.random) return this;
    final random = rng ?? _rng;
    return concrete[random.nextInt(concrete.length)];
  }
}

final math.Random _rng = math.Random();

/// Wraps [child] (the incoming photo) in the animation for [effect].
///
/// [animation] runs from 0 (photo not yet visible) to 1 (photo fully shown).
/// The outgoing photo simply stays below in the stack at full opacity, so
/// every effect only has to animate the new slide in.
Widget buildSlideTransition({
  required TransitionEffect effect,
  required Animation<double> animation,
  required Widget child,
}) {
  switch (effect) {
    case TransitionEffect.fade:
      return FadeTransition(opacity: animation, child: child);

    case TransitionEffect.slideRight:
    case TransitionEffect.slideLeft:
    case TransitionEffect.slideUp:
    case TransitionEffect.slideDown:
      return SlideTransition(
        position: Tween<Offset>(
          begin: _slideBegin(effect),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
        child: child,
      );

    case TransitionEffect.zoomIn:
      return _scaleWithFade(animation, child, begin: 0.85);

    case TransitionEffect.zoomOut:
      return _scaleWithFade(animation, child, begin: 1.18);

    case TransitionEffect.rotate:
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: animation,
        child: RotationTransition(
          turns: Tween<double>(begin: -0.04, end: 0.0).animate(curved),
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.12, end: 1.0).animate(curved),
            child: child,
          ),
        ),
      );

    case TransitionEffect.flip:
      return AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, inner) {
          final t = Curves.easeOutCubic.transform(animation.value.clamp(0.0, 1.0));
          final matrix = Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateY((1.0 - t) * (math.pi / 3));
          return Opacity(
            opacity: animation.value.clamp(0.0, 1.0),
            child: Transform(
              alignment: Alignment.center,
              transform: matrix,
              child: inner,
            ),
          );
        },
      );

    case TransitionEffect.blur:
      return AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, inner) {
          final t = animation.value.clamp(0.0, 1.0);
          // Sigma must stay > 0, otherwise ImageFiltered draws nothing.
          final sigma = math.max(0.01, (1.0 - t) * 24.0);
          return Opacity(
            opacity: t,
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: inner,
            ),
          );
        },
      );

    case TransitionEffect.random:
      // Should never happen: callers resolve() before building. Fall back to fade.
      return FadeTransition(opacity: animation, child: child);
  }
}

Offset _slideBegin(TransitionEffect effect) {
  switch (effect) {
    case TransitionEffect.slideRight:
      return const Offset(1.0, 0.0); // enters from the right edge
    case TransitionEffect.slideLeft:
      return const Offset(-1.0, 0.0);
    case TransitionEffect.slideUp:
      return const Offset(0.0, 1.0); // enters from the bottom, moving up
    case TransitionEffect.slideDown:
      return const Offset(0.0, -1.0);
    default:
      return Offset.zero;
  }
}

Widget _scaleWithFade(Animation<double> animation, Widget child, {required double begin}) {
  return FadeTransition(
    opacity: animation,
    child: ScaleTransition(
      scale: Tween<double>(begin: begin, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      ),
      child: child,
    ),
  );
}
