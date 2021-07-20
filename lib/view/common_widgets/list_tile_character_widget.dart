import 'package:firebase_rick_and_morty/model/character_model.dart';
import 'package:firebase_rick_and_morty/view/detail/detail_view.dart';
import 'package:flutter/material.dart';

class ListTileCharacterWidget extends StatelessWidget {
  final CharacterModel model;
  const ListTileCharacterWidget({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        child: Image.network(model.image ??
            "https://rickandmortyapi.com/api/character/avatar/19.jpeg"),
      ),
      title: Text(model.name ?? ""),
      subtitle: Text(model.species ?? ""),
      trailing: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailView(
                model: model,
              ),
              settings: RouteSettings(name: "DetailView"),
            ),
          );
        },
        child: Text("Detalhes"),
      ),
    );
  }
}
