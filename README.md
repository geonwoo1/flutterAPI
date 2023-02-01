# [플러터]api통신 쇼핑몰 데이터 가져오기

# GetX 사용하여 쇼핑 앱 만들기

[KakaoTalk_20221226_194212354.mp4](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/050ebad5-43f3-4704-afb5-8c41ca54ddfd/KakaoTalk_20221226_194212354.mp4)

- 사용 라이브러리
    
    GetX , http
    
- 사용 api 주소
    
    `https://makeup-api.herokuapp.com`
    
- 화면 설계

       - 그리드 뷰 이용해 api 데이터 갯수 만큼 생성

- 그리드뷰 코드
    
    ```dart
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
    ```
    
    ```dart
    Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    height: 80,
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
              SizedBox(height: 8),
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
                  fontSize: 20,
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
                    },
                    iconSize: 18,
                  ),
                ),
                ),
              ]),
            ]),
          ),
        );
    ```
    

    -  타일 하나에 Column 으로 이미지, 상품명, 별점 , 가격 생성 

    

- 하트아이콘 클릭시 좋아요 표시

![image](https://user-images.githubusercontent.com/90121680/215961991-f685e7e1-7db4-4588-8b51-3ef8a26b083b.png)

- 좋아요기능 코드    
    ```dart
    Obx(()=> CircleAvatar(
        backgroundColor: Colors.white,
        radius: 15,
        child: IconButton(
        icon: product.like.value ? Icon(Icons.favorite_rounded,color: Colors.pink,)
       :  Icon(Icons.favorite_border, color: Colors.pink,),
             onPressed: () {
             product.like.toggle();
                },
              iconSize: 18,
    ),
               ),
            ),
    ```
    

# api  데이터 모델 만들기

- api 데이터

    주소 [https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline](https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline)

- product 모델 코드
    
    ```dart
    import 'dart:convert';
    import 'package:get/get.dart';
    
    /*
     json 모델 변환 사이트 https://app.quicktype.io/ 이용
        => json 형식 파일을 붙여 넣으면 모델을 생성해준다
    */
    
    List<Product> productFromJson(String str) =>
        List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
    
    String productToJson(List<Product> data) =>
        json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
    
    class Product {
      Product({
        required this.id,
        required this.brand,
        required this.name,
        required this.price,
        this.priceSign,
        this.currency,
        required this.imageLink,
        required this.productLink,
        required this.websiteLink,
        required this.description,
        required this.rating,
        required this.category,
        required this.productType,
        required this.tagList,
        required this.createdAt,
        required this.updatedAt,
        required this.productApiUrl,
        required this.apiFeaturedImage,
        required this.productColors,
      });
    
      int? id;
      Brand? brand;
      String name;
      String price;
      dynamic priceSign;
      dynamic currency;
      String imageLink;
      String productLink;
      String websiteLink;
      String description;
      var rating;
      var category;
      String productType;
      List<dynamic> tagList;
      DateTime createdAt;
      DateTime updatedAt;
      String productApiUrl;
      String apiFeaturedImage;
      List<ProductColor> productColors;
    
      var like = false.obs;
    
      factory Product.fromJson(Map<String, dynamic> json) => Product(
    
        brand: brandValues.map[json["brand"]],
        name: json["name"],
        price: json["price"],
        priceSign: json["price_sign"],
        currency: json["currency"],
        imageLink: json["image_link"],
        productLink: json["product_link"],
        websiteLink: json["website_link"],
        description: json["description"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        category: json["category"] == null ? null : json["category"],
        productType: json["product_type"],
        tagList: List<dynamic>.from(json["tag_list"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productApiUrl: json["product_api_url"],
        apiFeaturedImage: json["api_featured_image"],
        productColors: List<ProductColor>.from(json["product_colors"].map((x) => ProductColor.fromJson(x))), id: null,
      );
    
      Map<String, dynamic> toJson() => {
    
        "brand": brandValues.reverse[brand],
        "name": name,
        "price": price,
        "price_sign": priceSign,
        "currency": currency,
        "image_link": imageLink,
        "product_link": productLink,
        "website_link": websiteLink,
        "description": description,
        "rating": rating == null ? null : rating,
        "category": category == null ? null : category,
        "product_type": productType,
        "tag_list": List<dynamic>.from(tagList.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_api_url": productApiUrl,
        "api_featured_image": apiFeaturedImage,
        "product_colors":
        List<dynamic>.from(productColors.map((x) => x.toJson())),
      };
    }
    
    enum Brand { MAYBELLINE }
    
    final brandValues = EnumValues({"maybelline": Brand.MAYBELLINE});
    
    class ProductColor {
      ProductColor({
        required this.hexValue,
        required this.colourName,
      });
    
      String hexValue;
      var colourName;
    
      factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
        hexValue: json["hex_value"],
        colourName: json["colour_name"] == null ? null : json["colour_name"],
      );
    
      Map<String, dynamic> toJson() => {
        "hex_value": hexValue,
        "colour_name": colourName == null ? null : colourName,
      };
    }
    
    class EnumValues<T> {
      Map<String, T> map;
      late Map<T, String> reverseMap;
    
      EnumValues(this.map);
    
      Map<T, String> get reverse {
        reverseMap = map.map((k, v) => new MapEntry(v, k));
        return reverseMap;
      }
    }
    ```
    

# http 통신

import 'package:food/model/productModel.dart';
import 'package:http/http.dart' as http;

class Api{
  static varclient= http.Client();

  static Future<List<Product>?>fetchProducts() async{

    //api에서 데이터 가져오기
    var response = awaitclient.get(Uri.parse('https://makeup-api.herokuapp.com'
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
