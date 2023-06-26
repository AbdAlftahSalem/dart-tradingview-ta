import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tradingview_ta/src/constant/network_constant.dart';

class DioManagerClass {
  DioManagerClass._();

  static final DioManagerClass getInstance = DioManagerClass._();

  Dio? _dio;

  Dio init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: NetworkConst.baseUrl,
        responseType: ResponseType.json,
        contentType: "application/json",
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "User-Agent": "tradingview_ta/3.3.0",
        },
      ),
    );
    return _dio!;
  }

  Future<Response> dioGetMethod({
    required String url,
    Map<String, dynamic> header = const {},
    Map<String, dynamic> queryParameters = const {},
  }) async {
    return await _dio!.get(
      url,
      options: Options(headers: header),
      queryParameters: queryParameters,
    );
  }

  Future<Response> dioPostMethod({
    required String url,
    Map<String, dynamic> header = const {},
    Map<String, dynamic> queryParameters = const {},
    required Map<String, dynamic> body,
  }) async {
    return await _dio!.post(
      "$url/scan",
      queryParameters: queryParameters,
      options: Options(headers: header),
      data: body,
    );
  }
}
