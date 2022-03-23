import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:fitness_app/model.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key? key, this.exercises, this.seconds}) : super(key: key);
  Exercises? exercises;
  int? seconds;

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late Timer timer;
  bool isComplete = false;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  final String soundPath = "music.mp3";
  int initSecond = 0;

  void playAudio() async {
    await audioCache.play(soundPath);
  }

  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.seconds) {
        timer.cancel();
        setState(() {
          isComplete = true;
          playAudio();
        });
        Future.delayed(Duration(seconds: 4), () {
          Navigator.pop(context);
        });
      }
      setState(() {
        initSecond = timer.tick;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    audioPlayer.dispose();
    audioPlayer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.network(
              "${widget.exercises!.gif}",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 20,
              child: Text("$initSecond / ${widget.seconds}"),
            )
          ],
        ),
      ),
    );
  }
}
