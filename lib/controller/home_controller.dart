import 'package:firebase_rick_and_morty/model/character_model.dart';
import 'package:firebase_rick_and_morty/repository/characteres_repository.dart';

class HomeController {
  CharacteresRepository _repository = CharacteresRepository();

  Future<List<CharacterModel>> loadCharacters(int page) async {
    return await _repository.getCharacteres(
        "https://rickandmortyapi.com/api/character/?page=$page");
  }
}
