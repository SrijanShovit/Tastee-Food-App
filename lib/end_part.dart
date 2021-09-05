import 'package:flutter/material.dart';
import 'package:tastee_food_app/Routing/routng_page.dart';
import 'package:tastee_food_app/login_page.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';
import 'package:tastee_food_app/signup.dart';
class EndPart extends StatelessWidget {
  const EndPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
          text: "LOG IN",
        ),
        SizedBox(height: 20,),
        GestureDetector(
            onTap: (){
              RoutingPage.goToNext(context: context, navigateTo: SignUp());
            },
            child: Text('Sign Up'))
      ],
    );
  }
}
