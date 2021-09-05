import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/checkout.dart';
import 'package:tastee_food_app/Routing/routng_page.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';
import 'package:tastee_food_app/mywidgets/single_itemincart.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyButton(
        text: "Check Out",
        onPressed: (){
          RoutingPage.goToNext(context: context, navigateTo: CheckoutPage());
        },
      ),
      appBar: AppBar(
        elevation: 0,
      ),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("userCart").snapshots(),

        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return streamSnapshot.data!.docs.isEmpty ?
              Center(
                child: Text("No items in your cart"),
              )
              : ListView.builder(

            physics: BouncingScrollPhysics(),
            //to avoid infinite looping
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (ctx, index) {
              var data = streamSnapshot.data!.docs[index];
              return SingleCartItem(
                productId: data["productId"],
                productCategory: data["productCategory"],
                productImage: data["productImage"],
                productPrice: data["productPrice"],
                productQuantity: data["productQuantity"],
                productName: data["productName"],

              );
            },
          );
        },

      ),
    );
  }
}


