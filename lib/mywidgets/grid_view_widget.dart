import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/mywidgets/single_products.dart';

class GridViewWidget extends StatelessWidget {

  final String id;
  final String collection;

  const GridViewWidget({Key? key,required this.collection,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: FutureBuilder(
        // id se hi pata chalega kis document ka data
          future: FirebaseFirestore.instance.collection("categories").doc(id).collection(collection).get(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

            if (!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Material(
                    elevation: 7,
                    shadowColor: Colors.grey[300],
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Search your favourite items",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )
                      ),
                    ),
                  ),
                ),

                GridView.builder(
                  shrinkWrap: true,
                   itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.4,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20
                    ),
                    itemBuilder:  (context,index){
                    var data = snapshot.data!.docs[index];
                      return SingleProduct(
                        onTap: () {},
                        image: data["productImage"],
                        name: data["productName"],
                        price: data["productPrice"],
                      );
                    }
                ),


              ],
            );
          })
          //



    );
  }
}
