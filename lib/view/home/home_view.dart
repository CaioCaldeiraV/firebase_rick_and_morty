import 'package:firebase_rick_and_morty/controller/home_controller.dart';
import 'package:firebase_rick_and_morty/model/character_model.dart';
import 'package:firebase_rick_and_morty/model/pop_up_model.dart';
import 'package:firebase_rick_and_morty/services/analytics_firebase_service.dart';
import 'package:firebase_rick_and_morty/view/favorite/favorite_view.dart';
import 'package:firebase_rick_and_morty/view/common_widgets/list_tile_character_widget.dart';
import 'package:firebase_rick_and_morty/view/home/pop_up_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = HomeController();
  int page = 1;

  @override
  void initState() {
    verifyPopUP();
    super.initState();
  }

  void verifyPopUP() async {
    PopUpModel _popUpModel = await controller.getInfoPopUP();
    if (_popUpModel.activate ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopUpWidget(
            model: _popUpModel,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + MediaQuery.of(context).padding.top + 70),
        child: AppBar(
          brightness: Brightness.dark,
          title: Text("Characters"),
          centerTitle: true,
          flexibleSpace: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: kToolbarHeight + MediaQuery.of(context).padding.top,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 35,
                      ),
                      onPressed: () {
                        if (page != 1)
                          setState(() {
                            page = page - 1;
                          });
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Page",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "$page",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 35,
                      ),
                      onPressed: () {
                        if (page != 34) {
                          setState(() {
                            page = page + 1;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<CharacterModel>>(
        future: controller.loadCharacters(page),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Algo de inesperado ocorreu!"),
            );
          } else {
            AnalyticsService.instance.logPageCharacteres(snapshot.data!, page);
            var list = ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  if (index + 1 == snapshot.data!.length) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTileCharacterWidget(model: snapshot.data![index]),
                        Container(
                          height: 70,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Created by: Caio Caldeira",
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                              Text(
                                "Objective: Test Firebase Features",
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListTileCharacterWidget(
                        model: snapshot.data![index]);
                  }
                });
            return list;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FavoriteView(),
            ),
          );
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}
