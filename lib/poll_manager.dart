import 'package:flutter/material.dart';

import './poll_control.dart';

class PollManager extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('Morning drink?', style:Theme.of(context).textTheme.headline),
      ),
      body: PollControl()
    );
  }
}