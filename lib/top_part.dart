import 'package:flutter/material.dart';

class Top extends StatelessWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Column(
        children: [
          Text('Welcome to Tastee Food App'),
          Text('Explore your delight'),
        ],
      ),
    ]
    );
  }
}
