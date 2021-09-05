import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/home_page.dart';
import 'package:tastee_food_app/ProviderComponents/login_auth_provider.dart';
import 'package:tastee_food_app/ProviderComponents/signup_auth_provider.dart';
import 'package:tastee_food_app/signup.dart';
import 'package:tastee_food_app/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create:(context)=>SignUpAuthProvider()
        ),
        ChangeNotifierProvider(
            create:(context)=>LoginAuthProvider()
        )
      ],
      child: MaterialApp(
        title: 'Tastee Food',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        //home: SignUp(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,userSnapshot){
            if (userSnapshot.hasData){
              return HomePage();
            }
            return WelcomePage();
          },
        ),
      ),
    );
  }
}



