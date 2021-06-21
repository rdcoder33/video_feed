import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class APIService {
  late Dio _dio;

  final String baseUrl = 'https://api.winkl.in';

  APIService() {
    _dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          headers: {'Authorization': 'Token ruor7REQi9KJz6wIQKDXvwtt'}),
    );
    initInterceptor();
  }

  Future<Response > getVideos(String endPoint) async {
    Response response;
    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print('Error_');
      debugPrint(e.message);

      throw Exception(e.message);
    }
    return response ;
  }

  initInterceptor() {
    _dio.interceptors
        .add(InterceptorsWrapper(onError: (DioError err, errHandler) {
     
      return errHandler.next(err);
    }, onRequest: (req, reqHandler) {
     
      return reqHandler.next(req);
    }, onResponse: (res, resHandler) {
      
      return resHandler.next(res);
    }));
  }

  @override
  String toString() => 'APIService(_dio: $_dio)';
}
