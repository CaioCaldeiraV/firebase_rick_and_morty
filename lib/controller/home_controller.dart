import 'dart:convert';
import 'package:firebase_rick_and_morty/model/character_model.dart';
import 'package:firebase_rick_and_morty/model/pop_up_model.dart';
import 'package:firebase_rick_and_morty/repository/characteres_repository.dart';
import 'package:firebase_rick_and_morty/services/remote_config_firebase_service.dart';

class HomeController {
  CharacteresRepository _repository = CharacteresRepository();

  Future<List<CharacterModel>> loadCharacters(int page) async {
    return await _repository.getCharacteres(
        "https://rickandmortyapi.com/api/character/?page=$page");
  }

  Future<PopUpModel> getInfoPopUP() async {
    RemoteConfigService service = RemoteConfigService.instance;
    await service.initConfig();
    return PopUpModel.fromJson(json.decode(service.getPopUp()));
  }
}
