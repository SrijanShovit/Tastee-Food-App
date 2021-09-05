import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleCartItem extends StatefulWidget {

  final String productImage;
  final String productName;
  final int productPrice;
  final int productQuantity;
  final String productCategory;
  final String productId;



  const SingleCartItem({Key? key,
    required this.productId,
    required this.productPrice,
    required this.productImage,
    required this.productQuantity,
    required this.productName,
    required this.productCategory
  }) : super(key: key);

  @override
  _SingleCartItemState createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {

  int quantity = 1;

  void quantityFunction(){
    FirebaseFirestore.instance.collection("cart").doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart").doc(widget.productId).update({
            "productQuantity" : quantity
    });
  }

  void deleteProductFunction(){
    FirebaseFirestore.instance.collection("cart").doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart").doc(widget.productId).delete();
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(20),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
            )
          ]
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children:
        [
          Row(
          children: [
            Expanded(
                child: Container(

                  decoration: BoxDecoration(

                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.productImage)

                      )
                  ),
                )
            ),
            Expanded(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.productName,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(widget.productCategory,
                      // style: TextStyle(
                      //   fontSize: 18,
                      // ),
                    ),
                    Text("\$${widget.productPrice * widget.productQuantity}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IncrandDecr(
                          onPressed: (){
                            setState(() {
                              quantity++;
                              quantityFunction();
                            });
                          },
                          icon: Icons.add,
                        ),
                        Text(widget.productQuantity.toString()),
                        IncrandDecr(
                          onPressed: (){
                            if (quantity > 1){
                              setState(() {
                                quantity--;
                                quantityFunction();
                              });
                            }

                          },
                          icon: Icons.remove,
                        ),

                        // MaterialButton(
                        //   minWidth:40,
                        //   height: 30,
                        //   onPressed: (){},
                        //     color: Colors.blue,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadiusDirectional.circular(20)
                        //   ),
                        //   ),
                      ],
                    )
                  ],
                ),
              ),

            ),
          ],
        ),
          
          IconButton(onPressed: (){
            deleteProductFunction();
          },
              icon:Icon(Icons.close))
    ],
      ),

    );
  }
}


class IncrandDecr extends StatelessWidget {

  final Function()? onPressed;
  final IconData icon;
  const IncrandDecr({Key? key,
    required this.icon,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth:40,
      height: 30,
      onPressed: onPressed,
      elevation: 2,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: Icon(icon),
    );
  }
}

