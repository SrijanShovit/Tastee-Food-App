import 'package:flutter/material.dart';
import 'package:tastee_food_app/mywidgets/mybutton.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Product Name",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),

            Row(
              children: [
                Text('\$40'),
                SizedBox(width: 20,),
                Text('\$40'),
              ],
            ),

            Divider(
              thickness: 2,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Center(
                    child: Text("4.5",
                      style: TextStyle(
                          color: Colors.white
                      ),),
                  ),
                ),

                Text("50 reviews",style: TextStyle(
                    color: Colors.teal
                ),),

              ],
            ),

            Column(
              children: [
                Divider(
                  thickness: 2,
                ),
                Text("Description",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                Text("Description"),
                MyButton(
                    onPressed: (){},
                    text: "Add to Cart")
              ],
            ),

          ],
        )
    );
  }
}
