import 'package:flutter/material.dart';
import 'package:food/controller/controller.dart';
import 'package:get/get.dart';
import 'product.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GW Shop'),
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.view_list_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Obx(() => GridView.builder(
            // gridDelegate 그리드뷰가 어떤 모양을 가질지 결졍해줌
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,     //그리드뷰 세로 갯수
                mainAxisSpacing: 10,
                crossAxisSpacing: 10
            ),
            itemBuilder: (context, index){
              return ProductTile(
                controller.productList[index],
              );
            },
            itemCount: controller.productList.length,
          ),
          ),
        ),
      ),
    );
  }
}