import 'package:food/data/api.dart';
import 'package:food/model/productModel.dart';
import 'package:get/get.dart';


class Controller extends GetxController{
  var productList = <Product>[].obs;  // 프로덕트리스트 불러오기

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async{
    var products = await Api.fetchProducts();
    if(products !=null){
      productList.value = products;
    }
  }
}