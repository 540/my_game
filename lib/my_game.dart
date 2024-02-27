import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';
import 'package:my_game/my_level.dart';
import 'package:my_game/player.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  Player player = Player();
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    World world = MyLevel(player: player);

    CameraComponent cam = CameraComponent.withFixedResolution(
      width: 640,
      height: 360,
      world: world,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    cam.priority = 0;

    _addJoystick();

    addAll([cam, world]);
    return super.onLoad();
  }

  void _addJoystick() {
    joystick = JoystickComponent(
        knob: SpriteComponent(
          sprite: Sprite(
            images.fromCache('HUD/Knob.png'),
          ),
        ),
        background: SpriteComponent(
          sprite: Sprite(
            images.fromCache('HUD/Joystick.png'),
          ),
        ),
        margin: const EdgeInsets.only(left: 100, bottom: 40),
        priority: 1);

    add(joystick);
  }

  @override
  void update(double dt) {
    _updateJoystickMovement();
    super.update(dt);
  }

  void _updateJoystickMovement() {
    switch (joystick.direction) {
      case JoystickDirection.downLeft:
      case JoystickDirection.upLeft:
      case JoystickDirection.left:
        player.moveToTheLeftWithJoystick();
        break;
      case JoystickDirection.downRight:
      case JoystickDirection.upRight:
      case JoystickDirection.right:
        player.moveToTheRightWithJoystick();
        break;
      default:
        player.dontMove();
        break;
    }
  }
}
