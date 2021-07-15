import 'package:firebase_rick_and_morty/controller/home_controller.dart';
import 'package:firebase_rick_and_morty/model/character_model.dart';
import 'package:firebase_rick_and_morty/services/analytics_firebase_service.dart';
import 'package:firebase_rick_and_morty/view/detail/detail_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();
  int page = 1;

  @override
  void initState() {
    super.initState();
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
          } else {
            AnalyticsService.instance.logPageCharacteres(snapshot.data!, page);
            var list = ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      child: Image.network(snapshot.data![index].image!),
                    ),
                    title: Text(snapshot.data![index].name!),
                    subtitle: Text(snapshot.data![index].species!),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailView(
                              model: snapshot.data![index],
                            ),
                            settings: RouteSettings(name: "DetailView"),
                          ),
                        );
                      },
                      child: Text("Detalhes"),
                    ),
                  );
                });
            return list;
          }
        },
      ),
    );
  }
}
