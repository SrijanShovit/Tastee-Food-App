import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/Model/user_model.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/home_page.dart';
import 'package:tastee_food_app/ProviderComponents/login_auth_provider.dart';
import 'package:tastee_food_app/ProviderComponents/signup_auth_provider.dart';
import 'package:tastee_food_app/Routing/routng_page.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';



class ProfilePage extends StatefulWidget {



  //const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static Pattern pattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp  = RegExp(SignUpAuthProvider.pattern.toString());

  bool isEdit = false;
  TextEditingController fullName = TextEditingController(text: userModel.fullname);
  TextEditingController emailAddress = TextEditingController(text: userModel.emailAddress);

  void profilePageValidation({
    required TextEditingController? fullname,
    required TextEditingController? emailAddress,
    required BuildContext context

  }) async{
    if (fullname!.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Name should not be empty'),
          )
      );
      return;
    }
    else if (emailAddress!.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email  should not be empty'),
          )
      );
      return;
    }
    else if (!regExp.hasMatch(emailAddress!.text.trim())){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email is invalid'),
          )
      );
      return;
    }

    else{
  buildUpdateProfile();
    }
  }
  Widget textFormField({required String hintText}){
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: ListTile(
        leading: Text(hintText),
      ),
    );


    //Edit Profile Page Validation

  }

  Widget nonEditTextField(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/chat.jpg'),
              radius: 50,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        textFormField(hintText: userModel.fullname),
        SizedBox(
          height: 10,
        ),
        textFormField(hintText: userModel.emailAddress),
      ],
    );
  }


  Future buildUpdateProfile() async {
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "Fullname" : fullName.text,
      "emailAddress" : emailAddress.text
    }).then((value) => RoutingPage.goToNext(context: context, navigateTo: HomePage()));
  }

  //build was called in homepg with updated data drom firebase
  //so we needed to navigate to homepg in order to update profile

  Widget editTextField(){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.edit))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/chat.jpg'),
                  radius: 50,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: fullName,
                decoration: InputDecoration(
                    hintText: "Full Name"
                ),),

            TextFormField(
                controller: emailAddress,
                decoration: InputDecoration(
                    hintText: "Email Address"
                ),),


            MyButton(onPressed: (){
              profilePageValidation(emailAddress: emailAddress,fullname: fullName,context: context);

            }, text: "Save Changes")
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){
            RoutingPage.goToNext(context: context, navigateTo: editTextField());
          }, icon: Icon(Icons.edit))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/chat.jpg"),
                            radius: 50,
                          ),
                        ],
                      ),
                      textFormField(hintText: userModel.fullname),
                      textFormField(hintText: userModel.emailAddress),
                    ],
                )
              ),

              Expanded(child: Container()),




            //  MyButton(onPressed: () {}, text: "Edit Profile")

            ],
          ),
        ),
      ),
    );
  }
}


