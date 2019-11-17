import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:greenlist/models/index.dart';

import 'index.dart';

class GreenListApi {
  static post(int productId, double treesDifference) async {
    return Api().dio.post("/greenList", data: {
      "productId": productId,
      "treesDifference": treesDifference,
    });
  }

  static Future<List<Product>> get() async {
    Response response = await Api().dio.get("/greenList");

    return (json.decode(response.data) as List)
        .map((p) => Product.fromJson(p))
        .toList();
  }
}
