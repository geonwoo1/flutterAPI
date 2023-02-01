import 'package:flutter/material.dart';
import 'package:food/model/productModel.dart';
import 'package:get/get.dart';

class ProductTile extends StatelessWidget {

  final Product product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Container(
                height: 65,
                width: 300,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.network(
                  product.imageLink,
                  fit: BoxFit.fill,
                ),
              ),
          SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 7),
          Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.rating.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(children:[
          Text(
            'Price :${product.price}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
            Obx(()=> CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15,
              child: IconButton(
                icon: product.like.value ? Icon(Icons.favorite_rounded,color: Colors.pink,)
                    :  Icon(Icons.favorite_border, color: Colors.pink,),
                onPressed: () {
                  product.like.toggle();
                  print(product.like);
                },
                iconSize: 18,
              ),
            ),
            ),

          ]),
        ]),
      ),
    );
  }
}