import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String productImage;

  const ProductImage({Key? key,
  required this.productImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                productImage
            )
          )
        ),
      ),
    );
  }
}
