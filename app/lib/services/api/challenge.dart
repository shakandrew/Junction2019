import 'package:dio/dio.dart';
import 'dart:convert';
import 'index.dart';

class ChallengeApi {
  static Future post(int months) {
    return Api().dio.post("/challenge", data: {"duration": months});
  }

  static Future<Map<String, dynamic>> get() {
    return Api()
        .dio
        .get("/challenge")
        .then((Response r) => json.decode(r.data));
  }
}
