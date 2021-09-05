import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/details_page_image.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ProductImage(),


            ]
        ),
      ),
    );
  }
}
