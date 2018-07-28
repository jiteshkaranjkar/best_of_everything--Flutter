import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  EmptyPlaceholder({
    this.title: 'Nothing yet',
    this.message: 'Add a new Poll to get started.',
  });
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text(title,
              style: TextStyle(fontSize: 32.0, color: Colors.black54),
              textAlign: TextAlign.center),
          Text(message,
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
              textAlign: TextAlign.center),
        ]));
  }
}
