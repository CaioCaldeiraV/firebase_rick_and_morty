import 'package:firebase_rick_and_morty/controller/favorite_controller.dart';
import 'package:firebase_rick_and_morty/model/character_model.dart';
import 'package:firebase_rick_and_morty/view/common_widgets/list_tile_character_widget.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  FavoriteController _favoriteController = FavoriteController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CharacterModel>>(
        future: _favoriteController.getFavoriteCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var list = ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTileCharacterWidget(model: snapshot.data![index]);
                });
            return list;
          }
        },
      ),
    );
  }
}
