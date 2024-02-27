import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:my_game/player.dart';

class MyLevel extends World {
  @override
  FutureOr<void> onLoad() async {
    TiledComponent level =
        await TiledComponent.load('Level-01.tmx', Vector2.all(16));

    add(level);

    Player player = Player(position: Vector2(0, 0));
    add(player);

    return super.onLoad();
  }
}
