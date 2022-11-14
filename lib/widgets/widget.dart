import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
final spinkit = SpinKitFadingFour(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(

      decoration: BoxDecoration(

        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);