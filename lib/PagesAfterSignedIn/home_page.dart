import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/Model/user_model.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/details_page.dart';
import 'package:tastee_food_app/Routing/routng_page.dart';
import 'package:tastee_food_app/login_page.dart';
import 'package:tastee_food_app/mywidgets/build_drawer.dart';
import 'package:tastee_food_app/mywidgets/grid_view_widget.dart';
import 'package:tastee_food_app/mywidgets/single_products.dart';


late UserModel userModel;  //global variable
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


 Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance.collection("users").doc(
      FirebaseAuth.instance.currentUser!.uid).get()
    .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists){
            userModel = UserModel.fromDocument(documentSnapshot);
          }else{
            print("Document does not exist");
          }
    })
    ;
  }


  @override
  Widget build(BuildContext context) {
    getCurrentUserDataFunction();
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
       // backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {
            //bs ayhi se likho firebase ka code
            FirebaseAuth.instance.signOut().then((value) =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()))
            );
          }
          , icon: Icon(Icons.exit_to_app,color: Colors.black,)
          )
        ],
      ),
      body: ListView(
        //to avoid overflow
        children: [


          //Search Bar
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


          ListTile(
            leading: Text('Categories',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.normal
            ),),
          ),


          Container(
            height: 150,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("categories").snapshots(),
              //Stream builder will update data as per in Firebase
              //In Future builder data updates on refreshing
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){

                if (!streamSnapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  //to avoid infinite looping
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (ctx,index){
                      return Categories(
                        onTap: (){
                          RoutingPage.goToNext(context: context, navigateTo: GridViewWidget(
                            collection: streamSnapshot.data!.docs[index]["categoryName"],
                            id: streamSnapshot.data!.docs[index].id,
                          ));
                        },
                           categoryName: streamSnapshot.data!.docs[index]["categoryName"],
                           image: streamSnapshot.data!.docs[index]["categoryImage"]
                      );

                   },
                );

              },
            ),
          ),



          // SingleChildScrollView(
          //   physics: BouncingScrollPhysics(),
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       Categories(
          //         categoryName: "Food",
          //         image: "assets/chat.jpg",
          //       ),
          //       Categories(
          //         categoryName: "Snack",
          //         image: "assets/chat.jpg",
          //       ),
          //     ],
          //   ),
          // ),

          ListTile(
            leading: Text('Products',
              style: TextStyle(
                  fontWeight: FontWeight.normal
              ),),
          ),

          Container(
            height: 280,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("product").snapshots(),
              //Stream builder will update data as per in Firebase
              //In Future builder data updates on refreshing
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){

                if (!streamSnapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  //to avoid infinite looping
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (ctx,index){
                    var data = streamSnapshot.data!.docs[index];
                    return SingleProduct(
                      onTap: (){
                        RoutingPage.goToNext(context: context, navigateTo: DetailsPage(
                          productCategory: data["productCategory"],
                          productId: data["productId"],
                          productImage: data["productImage"],
                            productName: data["productName"],
                            productPrice:data["productPrice"],
                            productOldPrice:data["productOldPrice"],
                            productRate: data["productRate"],
                            productDescription:data["productDescription"]
                        ));
                      },
                        image: data["productImage"],
                        name: data["productName"],
                        price: data["productPrice"]
                    );

                  },
                );

              },
            ),
          ),
          ListTile(
            leading: Text('Best Sell',
              style: TextStyle(
                  fontWeight: FontWeight.normal
              ),),
          ),

          Container(
            height: 280,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("product").where("productRate",isGreaterThan : 4).orderBy("productRate",descending: true,).snapshots(),
              //Stream builder will update data as per in Firebase
              //In Future builder data updates on refreshing
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){

                if (!streamSnapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  //to avoid infinite looping
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (ctx,index){
                    var data = streamSnapshot.data!.docs[index];
                    return SingleProduct(
                      onTap: (){
                        RoutingPage.goToNext(
                            context: context,
                            navigateTo: DetailsPage(
                                productCategory: data["productCategory"],
                                productId: data["productId"],
                        productImage: data["productImage"],
                        productName: data["productName"],
                        productPrice:data["productPrice"],
                        productOldPrice:data["productOldPrice"],
                        productRate: data["productRate"],
                        productDescription:data["productDescription"]
                            )
                        );
                      },

                        image: data["productImage"],
                        name: data["productName"],
                        price: data["productPrice"]
                    );

                  },
                );

              },
            ),
          ),

        ],
      ),



    );
  }
}





class Categories extends StatelessWidget {

  final String image;
  final String categoryName;
  final Function()? onTap;
  const Categories({Key? key,required this.onTap,required this.categoryName,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12),
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(

            fit: BoxFit.cover,
            image: NetworkImage(image)
          ),
        ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.7),
          ),
          child: Center(
            child: Text(categoryName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}
