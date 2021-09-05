import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastee_food_app/ProviderComponents/login_auth_provider.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';
import 'package:tastee_food_app/signup.dart';


 class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    bool loading =  false;
   TextEditingController? email = TextEditingController();
   bool visibility = true;
   TextEditingController? password = TextEditingController();

   @override
   Widget build(BuildContext context) {

     //instance creation
     LoginAuthProvider loginAuthProvider = Provider.of<LoginAuthProvider>(context);

     return Scaffold(
       body: Padding(
         padding: EdgeInsets.all(20),
         child: SafeArea(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

             children: [

               //top part
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Column(
                     children: [
                       Text('Logo'),
                       Text('Login'),
                     ],
                   )
                 ],
               ),

               //center part
               Column(
                 children: [

                   TextFormField(
                     controller: email,
                   decoration: InputDecoration(
                       hintText: "Your email"
                   ),
                 ),
                   TextFormField(
                     obscureText: visibility,
                     controller: password,
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
                   ),
                ]
               ),

               SizedBox(height: 20,),
               Column(
                 children:[

                   loading == true ?
                   CircularProgressIndicator() :
                    MyButton(
                       // loading:loginAuthProvider.loading,
                        onPressed: () {
                          loading = true;
                      loginAuthProvider.loginPageValidation(
                          email: email,
                          password: password,
                          context: context);
                    }, text: "LOG IN"),

                   SizedBox(height: 20,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Don't have an account"),
                       Spacer(),
                       GestureDetector(
                           onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(
                                 builder:(context) => SignUp()
                             ));
                           },
                           child: Text('SIGN UP'))
                     ],
                   ),
                   ],
                ),

             ],
           ),
         ),
       )
     );
   }
}
 