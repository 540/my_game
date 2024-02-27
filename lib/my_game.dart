import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:my_game/my_level.dart';

class MyGame extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    World world = MyLevel();

    CameraComponent cam = CameraComponent.withFixedResolution(
      width: 640,
      height: 360,
      world: world,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
    return super.onLoad();
  }
}
