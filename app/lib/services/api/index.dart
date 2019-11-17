import 'dart:convert';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

part 'log.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class Api {
  static final Api _initBlocSingleton = Api._internal();
  factory Api() => _initBlocSingleton;
  Api._internal();

  Dio dio;
  static String url = "https://greenlist.itis.team";

  void init([String uuid]) {
    BaseOptions options = new BaseOptions(
      baseUrl: Api.url,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: uuid != null
          ? {
              "GreenList-User-Id": uuid,
            }
          : {}, //uuid
    );
    dio = new Dio(options);
    //TODO: FOR DEV BUILDS ONLY {
    dio.interceptors.add(LogInterceptor());
    //TODO: } FOR DEV BUILDS ONLY
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
  }
}
