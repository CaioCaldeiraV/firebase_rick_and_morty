import 'package:dio/dio.dart';
import 'package:firebase_rick_and_morty/model/character_model.dart';

class CharacteresRepository {
  Future<List<CharacterModel>> getCharacteres(String url) async {
    try {
      var response = await Dio().get(url);
      List<CharacterModel> listCharacteres = <CharacterModel>[];
      response.data['results'].forEach((v) {
        listCharacteres.add(CharacterModel.fromJson(v));
      });
      return listCharacteres;
    } catch (e) {
      throw "Erro ao buscar personagens.";
    }
  }
}
