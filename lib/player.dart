import 'dart:async';

import 'package:flame/components.dart';
import 'package:my_game/my_game.dart';

enum PlayerState {
  idle,
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<MyGame> {
  Player({position}) : super(position: position);

  @override
  FutureOr<void> onLoad() {
    SpriteAnimation idleAnimation = SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('Main Characters/Mask Dude/Idle (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: 11,
        stepTime: 0.05,
        textureSize: Vector2.all(32),
      ),
    );

    animations = {PlayerState.idle: idleAnimation};

    current = PlayerState.idle;

    return super.onLoad();
  }
}
