import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastee_food_app/AppColours/app_colours.dart';
import 'package:tastee_food_app/ProviderComponents/signup_auth_provider.dart';
import 'package:tastee_food_app/login_page.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visibility = true;


  @override
  Widget build(BuildContext context) {

    //instance creation
    SignUpAuthProvider signUpAuthProvider = Provider.of<SignUpAuthProvider>(context);


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign Up'),
              Column(
                children: [
                  TextFormField(
                    controller: fullname,
                    decoration: InputDecoration(
                      hintText: "Your name"
                    ),
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "Your email"
                    ),
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: visibility,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            visibility = !visibility;
                          });

                        },
                        icon: Icon(
                            visibility ?  Icons.visibility_off : Icons.visibility ),
                      ),
                      hintText: "Your password"
                    ),
                  )
                ],
              ),
              SizedBox(height: 50,),
              signUpAuthProvider.loading == false ? MyButton(
                onPressed: () {
                  signUpAuthProvider.signupValidation(
                      context: context,
                      fullname: fullname,
                      email: email,
                      password: password
                  );
                },
                text: "SIGN UP",

              ): Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account',
                  style: TextStyle(
                    color: AppColours.Kgreycolor,
                  ),),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder:(context) => LoginPage()
                        ));
                      },
                      child: Text('LOG IN'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
