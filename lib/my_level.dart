import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:my_game/player.dart';

class MyLevel extends World {
  late TiledComponent _level;

  @override
  FutureOr<void> onLoad() async {
    _level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));
    add(_level);

    _spawnObjects();

    return super.onLoad();
  }

  void _spawnObjects() {
    final spawnPointsLayer = _level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            _addPlayer(spawnPoint);
            break;
          default:
            break;
        }
      }
    }
  }

  void _addPlayer(TiledObject tiledObject) {
    Player player = Player(position: Vector2(tiledObject.x, tiledObject.y));
    add(player);
  }
}
