import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

part 'animation_state.dart';

class AnimationCubit extends Cubit<AnimationState> {
  Timer? _slashTimer;
  Timer? _hitTimer;

  AnimationCubit() : super(AnimationState.initial());

  void onCardTapped(int index) {
    // Cancel existing timers
    _slashTimer?.cancel();
    _hitTimer?.cancel();

    // Play slash animation
    emit(state.copyWith(
      lastTappedIndex: index,
      currentAnimation: 'Slash',
    ));

    // Schedule Enemy_Hit animation
    _slashTimer = Timer(Duration(milliseconds: 500), () {
      emit(state.copyWith(currentAnimation: 'Enemy_Hit'));

      // Schedule damage number animation
      _hitTimer = Timer(Duration(milliseconds: 300), () {
        final hitCount = state.hitCount + 1;
        final damageAnimation = _getAnimationForHitCount(hitCount);
        emit(state.copyWith(
          hitCount: hitCount,
          currentAnimation: damageAnimation,
        ));
      });
    });
  }

  String _getAnimationForHitCount(int hitCount) {
    switch (hitCount) {
      case 0:
        return '435';
      case 1:
        return '435';
      case 2:
        return '284';
      case 3:
        return '189';
      case 4:
        return '52';
      case 5:
        return '9';
      case 6:
        return '2';
      default:
        return '2';
    }
  }

  @override
  Future<void> close() {
    _slashTimer?.cancel();
    _hitTimer?.cancel();
    return super.close();
  }
}
