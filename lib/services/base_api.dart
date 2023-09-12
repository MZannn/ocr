import 'package:dio/dio.dart';
import 'package:ocr_visitor/constants/string.dart';

class API {
  final Dio dio;
  static final API _api = API._internal(
    Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: const Duration(
          seconds: 15,
        ),
        receiveTimeout: const Duration(
          seconds: 15,
        ),
      ),
    ),
  );
  factory API() => _api;
  API._internal(this.dio);
}
