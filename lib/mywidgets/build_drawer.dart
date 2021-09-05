import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/home_page.dart';
import 'package:tastee_food_app/Profile/profile_page.dart';
import 'package:tastee_food_app/Routing/routng_page.dart';
import 'package:tastee_food_app/login_page.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Colors.purpleAccent
            ),
            accountName: Text(userModel.fullname),
            accountEmail: Text(userModel.emailAddress),
            currentAccountPicture: CircleAvatar(
              //background image
            ),
          ),
          ListTile(
            leading: IconButton(icon: Icon(Icons.person), onPressed: () {
              RoutingPage.goToNext(context: context, navigateTo: ProfilePage());
            },),
            title: Text('Profile'),
            //trailing: Text('Profile'),
          ),
          ListTile(
            leading: IconButton(icon: Icon(Icons.shopping_cart_rounded), onPressed: () {  },),
            title: Text('Cart'),
          ),
          ListTile(
            leading: IconButton(icon: Icon(Icons.favorite), onPressed: () {  },),
            title: Text('Favourite'),
          ),
          ListTile(
            leading: IconButton(icon: Icon(Icons.shopping_basket_rounded), onPressed: () {  },),
            title: Text('My Orders'),
          ),
          ListTile(
            leading: IconButton(onPressed: () {
            //bs ayhi se likho firebase ka code
                  FirebaseAuth.instance.signOut().then((value) =>
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()))
                   );
                },
                icon: Icon(Icons.exit_to_app,color: Colors.black,)
                ),
            title: Text('Log Out'),
          ),
        ],
      ),

    );
  }
}
