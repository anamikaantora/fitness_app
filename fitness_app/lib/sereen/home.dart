import 'dart:convert';

import 'package:fitness_app/model.dart';
import 'package:fitness_app/sereen/custom_appbar.dart';
import 'package:fitness_app/sereen/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Exercises> exercises = [];
  final String apiurl =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  fetchHomeData() async {
    final responce = await http.get(Uri.parse(apiurl));
    var data = responce.body;
    var decodeData = jsonDecode(data);

    for (var singleData in decodeData["exercises"]) {
      print(singleData);
      Exercises model = Exercises(
        id: singleData["id"],
        title: singleData["title"],
        thumbnail: singleData["thumbnail"],
        gif: singleData["gif"],
        //seconds:singleData["seconds"]
      );
      setState(() {
        exercises.add(model);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: ClipPath(
            clipper: CustomAppBar(),
            child: Container(
              color: Colors.blue[400],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Fitness App',
                    style:
                        TextStyle(color: Colors.deepOrangeAccent, fontSize: 25),
                  ),
                  Text(
                    'BEST APP 2022',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(kToolbarHeight + 150)),
      body: Container(
        width: double.infinity,
        child: exercises.isNotEmpty
            ? ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(
                                    exercises: exercises[index],
                                    jewel: exercises,
                                  )));
                    },
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      margin: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          children: [
                            FadeInImage(
                              placeholder: NetworkImage(
                                "https://t3.ftcdn.net/jpg/02/33/46/24/360_F_233462402_Fx1yke4ng4GA8TJikJZoiATrkncvW6Ib.jpg",
                              ),
                              image: NetworkImage(
                                "${exercises[index].thumbnail}",
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 120,
                                  padding: EdgeInsets.all(20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xff000000),
                                          Color(0x00000000),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter),
                                  ),
                                  child: Text(
                                    "${exercises[index].title}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: Column(
                children: [spinkit, Text("Loading")],
              )),
      ),
    );
  }
}
