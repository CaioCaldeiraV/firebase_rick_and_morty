import 'package:firebase_rick_and_morty/model/character_model.dart';

class FavoriteController {
  Future<List<CharacterModel>> getFavoriteCharacters() async {
    await Future.delayed(Duration(seconds: 3));
    return [];
  }
}
