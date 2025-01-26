part of 'animation_cubit.dart';

class AnimationState {
  final int lastTappedIndex;
  final int hitCount;
  final String currentAnimation;

  AnimationState({
    required this.lastTappedIndex,
    required this.hitCount,
    required this.currentAnimation,
  });

  factory AnimationState.initial() => AnimationState(
        lastTappedIndex: -1,
        hitCount: 0,
        currentAnimation: 'Line_Idle_Ross',
      );

  AnimationState copyWith({
    int? lastTappedIndex,
    int? hitCount,
    String? currentAnimation,
  }) {
    return AnimationState(
      lastTappedIndex: lastTappedIndex ?? this.lastTappedIndex,
      hitCount: hitCount ?? this.hitCount,
      currentAnimation: currentAnimation ?? this.currentAnimation,
    );
  }
}
