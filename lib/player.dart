import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:my_game/my_game.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<MyGame>, KeyboardHandler {
  Player({position}) : super(position: position);

  double _horizontalMovement = 0;
  final double _moveSpeed = 100;
  final Vector2 _velocity = Vector2.zero();

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
    SpriteAnimation runningAnimation = SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('Main Characters/Mask Dude/Run (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: 12,
        stepTime: 0.05,
        textureSize: Vector2.all(32),
      ),
    );

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation
    };

    return super.onLoad();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    dontMove();

    final hasToMoveToTheLeft =
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final hasToMoveToTheRight =
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (hasToMoveToTheLeft) {
      _moveToTheLeft();
    } else if (hasToMoveToTheRight) {
      _moveToTheRight();
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void dontMove() {
    _horizontalMovement = 0;
  }

  void _moveToTheLeft() {
    _horizontalMovement += -1;
  }

  void _moveToTheRight() {
    _horizontalMovement += 1;
  }

  void moveToTheLeftWithJoystick() {
    _horizontalMovement = -1;
  }

  void moveToTheRightWithJoystick() {
    _horizontalMovement = 1;
  }

  @override
  void update(double dt) {
    _updateMovement(dt);
    _updatePlayerState();

    super.update(dt);
  }

  void _updateMovement(double dt) {
    _velocity.x = _horizontalMovement * _moveSpeed;
    position.x += _velocity.x * dt;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (_velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (_velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    if (_velocity.x > 0 || _velocity.x < 0) playerState = PlayerState.running;

    current = playerState;
  }
}
