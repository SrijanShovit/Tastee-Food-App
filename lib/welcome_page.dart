import 'package:flutter/material.dart';
import 'package:tastee_food_app/top_part.dart';
import 'package:tastee_food_app/end_part.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Top(),
            EndPart(),
          ],
        ),
      ),
    );
  }
}
