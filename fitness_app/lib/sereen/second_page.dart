import 'package:fitness_app/model.dart';
import 'package:fitness_app/sereen/third_page.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SecondPage extends StatelessWidget {
  // const SecondPage({Key? key}) : super(key: key);

  Exercises? exercises;
  List<Exercises>? jewel;
  int? seconds;
  SecondPage({this.exercises, this.jewel});
  //Exercises({this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.network(
              "${exercises!.thumbnail}",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            customWidths:
                                CustomSliderWidths(progressBarWidth: 10)),
                        min: 10,
                        max: 28,
                        initialValue: 14,
                        onChange: (double value) {
                          seconds = value.toInt();
                          print("$value");
                        },
                        innerWidget: (v) {
                          return Center(
                            child: Text(
                              "${v.toStringAsFixed(0)} sec",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ThirdPage(
                                  exercises: exercises,
                                  seconds: seconds,
                                )));
                      },
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      minWidth: 120,
                      height: 50,
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
