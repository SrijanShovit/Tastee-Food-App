import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {

  final String image;
  final int price;
  final String name;
  final Function()? onTap;
  const SingleProduct({Key? key,
    required this.onTap,
    required this.image,required this.name,required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(

        children: [
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image

                )
              )
            ),
            height: 200,
            width: 150,

          ),



          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),),
              SizedBox(width: 20,),
              Text("\$$price",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),


            ],
          )
        ],
      ),
    );
  }
}