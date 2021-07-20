import 'dart:async';

import 'package:firebase_rick_and_morty/model/character_model.dart';

class FavoriteController {
  StreamController<bool> streamIsFavorite = StreamController();

  Future<List<CharacterModel>> getFavoriteCharacters() async {
    return [];
  }

  Future<bool> isCharacterfavorite(int id) async {
    return true;
  }

  Future<bool> setFavoriteCharacter(bool isFavorite) async {
    return !isFavorite;
  }

  void closeStream() {
    streamIsFavorite.close();
  }
}
