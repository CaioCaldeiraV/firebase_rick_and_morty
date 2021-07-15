import 'package:firebase_rick_and_morty/model/character_model.dart';
import 'package:firebase_rick_and_morty/services/analytics_firebase_service.dart';
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  final CharacterModel model;
  const DetailView({Key? key, required this.model}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    AnalyticsService.instance.logSelectedCharacter(widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              widget.model.image ?? "",
              scale: 0.1,
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.height * 0.075,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Name: ",
                        ),
                        TextSpan(
                          text: widget.model.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Gender: ",
                        ),
                        TextSpan(
                          text: widget.model.gender,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Espécie: ",
                        ),
                        TextSpan(
                          text: widget.model.species,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Status: ",
                        ),
                        TextSpan(
                          text: widget.model.status,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Type: ",
                        ),
                        TextSpan(
                          text: widget.model.type,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Location: ",
                        ),
                        TextSpan(
                          text: widget.model.location!.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Origin: ",
                        ),
                        TextSpan(
                          text: widget.model.origin!.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.075,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).backgroundColor),
            elevation: MaterialStateProperty.all(10),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Back",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
