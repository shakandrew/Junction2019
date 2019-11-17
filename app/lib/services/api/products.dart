import 'package:dio/dio.dart';
import 'package:greenlist/models/index.dart';

import 'index.dart';

class ProductsApi {
  static Future<List<Product>> suggestions() async {
    Response response = await Api().dio.get("/productSuggestions");
    
    return (response.data as List)
        .map((p) => Product.fromJson(p))
        .toList();
  }
}
