import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class MyLevel extends World {
  @override
  FutureOr<void> onLoad() async {
    TiledComponent level =
        await TiledComponent.load('Level-01.tmx', Vector2.all(16));

    add(level);

    return super.onLoad();
  }
}
