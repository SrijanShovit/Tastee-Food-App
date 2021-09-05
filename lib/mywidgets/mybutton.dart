import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
final  void Function()? onPressed;
final String text;
//Jis widget mein call hoga waha ka data pe kaam krega
  MyButton({required this.onPressed,required this.text});


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height:50,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
      ),

      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xff027f47),
                  Color(0xff01a95c),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
            ),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(text),
        ),
      ),
    );
  }
}
