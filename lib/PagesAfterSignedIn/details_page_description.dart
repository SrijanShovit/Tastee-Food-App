import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/cart.dart';
import 'package:tastee_food_app/Routing/routng_page.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';

class ProductDescription extends StatelessWidget {

  final String productImage;
  final String productName;
  final int productPrice;
  final int productOldPrice;
  final int productRate;
  final String productDescription;
  final String productId;
  final String productCategory;

  const ProductDescription({Key? key,
  required this.productName,
    required this.productImage,
    required this.productOldPrice,
    required this.productPrice,
    required this.productRate,
    required this.productDescription,
    required this.productId,
    required this.productCategory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              productName,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),

            Row(
              children: [
                Text("Old Price: \$ $productOldPrice"),
                SizedBox(width: 20,),
                Text('Current Price: \$ $productPrice'),
              ],
            ),

            Divider(
              thickness: 2,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Center(
                    child: Text(productRate.toString(),
                      style: TextStyle(
                          color: Colors.white
                      ),),
                  ),
                ),

                Text("50 reviews",style: TextStyle(
                    color: Colors.teal
                ),),

              ],
            ),

            Column(
              children: [
                Divider(
                  thickness: 2,
                ),
                Text("Description",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                Text(productDescription),
                MyButton(
                    onPressed: (){
                      
                      //before navigating to cart page we should send data to firebase
                      
                      FirebaseFirestore.instance.collection("cart").doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("userCart").doc(productId).set({
                        "productCategory":productCategory,
                        "productId":productId,
                        "productImage":productImage,
                        "productName":productName,
                        "productPrice":productPrice,
                        "productOldPrice":productOldPrice,
                        "productRate":productRate,
                        "productDescription":productDescription,
                        "productQuantity":1,
                      });

                      RoutingPage.goToNext(context: context, navigateTo: Cart());
                    },
                    text: "Add to Cart")
              ],
            ),

          ],
        )
    );
  }
}
