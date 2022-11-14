import 'dart:convert';

import 'package:fitness_app_day_34/model_class/model.dart';
import 'package:fitness_app_day_34/pages/second_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A";

  List<Exercise> allData = [];
  late Exercise exercise;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  bool isLoading = false;
  Future fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response = await http.get(Uri.parse(link));
      print("status code is ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var i in data["exercises"]) {
          exercise = Exercise(
              id: i["id"],
              title: i["title"],
              thumbnail: i["thumbnail"],
              seconds: i["seconds"],
              gif: i["gif"],
          );
          setState(() {
            allData.add(exercise);
          });
        }
        setState(() {
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
      //

    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("the problem is $e");
      showToast("Something wrong bro");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      blur: 0.5,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3F3B6C),
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
          title: Text(
            "Fitness App",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
              shrinkWrap: true,
              itemCount: allData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SecondPage(
                      exercise: allData[index],
                    )));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage("${allData[index].thumbnail}"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${allData[index].title}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
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
                );
              }),
        ),
      ),
    );
  }
}

showToast(String title) {
  return Fluttertoast.showToast(
      msg: "$title",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.purple,
      textColor: Colors.white,
      fontSize: 16.0);
}
