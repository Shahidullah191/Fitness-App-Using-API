import 'package:fitness_app_day_34/model_class/model.dart';
import 'package:fitness_app_day_34/pages/thired_page.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key, this.exercise}) : super(key: key);

  final Exercise? exercise;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  int second = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("${widget.exercise?.thumbnail}"),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SleekCircularSlider(
                  min: 20,
                  max: 25,
                  initialValue: second.toDouble(),
                  onChange: (double value) {
                    setState(() {
                      second = value.toInt();
                    });
                  },
                  innerWidget: (double value) {
                    return  Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${second.toStringAsFixed(0)}",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold)),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ThirdPage(
                                    exercise: widget.exercise,
                                    second: second,
                                  )));
                            },
                            child: Text("Start"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple.withOpacity(0.6)),
                          )
                        ],
                      ),
                    );

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
