import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';
import 'package:tastee_food_app/mywidgets/single_itemincart.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Expanded(
              child:  StreamBuilder(
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
          ),
          Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: Text("Sub Total"),
                    trailing: Text("\$ 5"),
                  ),
                  ListTile(
                    leading: Text("Discount"),
                    trailing: Text("\$ 1"),
                  ),
                  ListTile(
                    leading: Text("Delivery Charges"),
                    trailing: Text("\$ 1"),
                  ),
                  Divider(thickness: 2,),
                  ListTile(
                    leading: Text("Total"),
                    trailing: Text("\$ 1"),
                  ),
                  MyButton(onPressed: (){}, text: "Buy")

                ],
              )),
        ],
      ),
    );
  }
}
