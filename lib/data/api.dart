import 'package:food/model/productModel.dart';
import 'package:http/http.dart' as http;

class Api{
  static var client = http.Client();

  static Future<List<Product>?> fetchProducts() async{

    //api에서 데이터 가져오기
    var response = await client.get(Uri.parse('https://makeup-api.herokuapp.com'
        '/api/v1/products.json?brand=maybelline'));

    //상태가 정상이면 바디값 가져오기
    if(response.statusCode == 200){
      var jasonData = response.body;
      return productFromJson(jasonData);
    }else{
      return null;
    }
  }
}