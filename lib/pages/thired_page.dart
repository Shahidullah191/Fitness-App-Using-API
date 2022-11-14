import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app_day_34/model_class/model.dart';
import 'package:fitness_app_day_34/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/widget.dart';

class ThirdPage extends StatefulWidget {
   ThirdPage({Key? key, this.second, this.exercise}) : super(key: key);

  final Exercise? exercise;
  int? second;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  bool isPlaying = false;
  bool isComplete = false;
  int startSound = 0;
  late Timer timer;
  String musicPath = "assets/music.mp3";

  playAudio() async {
    // await audioCache.load(musicPath);
    // await audioPlayer.play(AssetSource(musicPath));
  }

  @override
  void initState() {
    // TODO: implement initState
    // playAudio();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var x = widget.second !-1;

      print("${x}");

      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          //isPlaying = true;
          playAudio();
          showToast("WorkOut Succesfull");
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        });
      }
      setState(() {
        startSound = timer.tick;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: "${widget.exercise!.gif}",
                fit: BoxFit.cover,
                placeholder: (context, url) => spinkit,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned(
                top: 15,
                left: 20,
                right: 20,
             child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Time Count: $startSound",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.purple.withOpacity(0.3),
                      Colors.blue.withOpacity(0.3),
                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
