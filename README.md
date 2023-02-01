# [플러터]api통신 쇼핑몰 데이터 가져오기

# GetX 사용하여 쇼핑 앱 만들기

- 사용 라이브러리
    
    GetX , http
    
- 사용 api 주소
    
    `https://makeup-api.herokuapp.com`
    
- 화면 설계

    - 그리드 뷰 이용해 api 데이터 갯수 만큼 생성
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
    /*
     json 모델 변환 사이트 https://app.quicktype.io/ 이용
        => json 형식 파일을 붙여 넣으면 모델을 생성해준다
    */ 
    

# http 통신

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
