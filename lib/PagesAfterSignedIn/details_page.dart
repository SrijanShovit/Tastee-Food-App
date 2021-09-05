import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/details_page_description.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/details_page_image.dart';


class DetailsPage extends StatelessWidget {

  //firebase ka kaam krne mein sbse pehle idhar liko
  //jo jo info chahiye idhar likho
  final String productCategory;
  final String productImage;
  final String productName;
  final int productPrice;
  final int productOldPrice;
  final int productRate;
  final String productDescription;
  final String productId;


  //constructor mein sbko pass kro as required
  const DetailsPage({Key? key,
    required this.productCategory,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productOldPrice,
    required this.productPrice,
    required this.productRate,
    required this.productDescription
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:10,horizontal: 15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ProductImage(
              productImage: productImage,
            ),
            ProductDescription(
              productCategory: productCategory,
                productImage: productImage,
              productId: productId,
                productName: productName,
                productOldPrice: productOldPrice,
                productPrice: productPrice,
                productRate: productRate,
                productDescription:productDescription
            ),


            ]
        ),
      ),
    );
  }
}
