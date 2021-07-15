import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_rick_and_morty/model/character_model.dart';

class AnalyticsService {
  AnalyticsService._privateConstructor();
  static final AnalyticsService _instance =
      AnalyticsService._privateConstructor();
  static AnalyticsService get instance => _instance;

  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics();
  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);

  Future logOpenApp() async {
    await _firebaseAnalytics.logAppOpen();
  }

  Future logPageCharacteres(
      List<CharacterModel> listCharacteres, int page) async {
    String idCharacters = "";
    for (int i = 0; i < listCharacteres.length; i++) {
      idCharacters += listCharacteres[i].id.toString() + " ";
    }
    await _firebaseAnalytics.logEvent(
      name: "characters_page",
      parameters: {
        'page': page,
        'idCharacters': idCharacters,
      },
    );
  }

  Future logSelectedCharacter(CharacterModel character) async {
    await _firebaseAnalytics.logSelectContent(
        contentType: 'selected_character', itemId: character.id.toString());
  }
}
