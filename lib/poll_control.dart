import 'package:flutter/material.dart';

import './poll_element.dart';

class PollControl extends StatelessWidget{
  final List<String> strList = ["Tea","Coffee","Juice","Shake","Milk","Water"];//, "Beer", "Vodka", "Wine"];

  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: strList.map((item) =>
            PollElement(poll: item)).toList()
        ),
      ],
    );
  }
}