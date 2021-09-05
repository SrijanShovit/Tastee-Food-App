import 'package:flutter/material.dart';

class RoutingPage {

  static goToNext({required BuildContext context,required Widget navigateTo}){
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) => navigateTo));

  }
}