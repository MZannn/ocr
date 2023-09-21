part of 'env.dart';

class API {
  final Dio dio;
  static final API _api = API._internal(
    Dio(
      BaseOptions(
        baseUrl: Constants.apiUrl,
        connectTimeout: Constants.timeout,
        receiveTimeout: Constants.timeout,
      ),
    ),
  );
  factory API() => _api;
  API._internal(this.dio);
}

class OCRApi {
  final API api = API();
  Future get<T extends Object?>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString('token');
      try {
        final response = await OCRApi().api.dio.get<T>(
              path,
              queryParameters: param,
              options: Options(
                headers: {
                  "Authorization": "Bearer ${token!}",
                },
              ),
            );
        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    } else {
      try {
        final response = await OCRApi().api.dio.get<T>(
              path,
              queryParameters: param,
            );
        return _returnResponse(response);
      } on DioException catch (e) {
        return _returnResponse(e.response!);
      }
    }
  }

  Future post<T extends Object?>(
      {required String path,
      bool withToken = true,
      dynamic formdata,
      Map<String, dynamic>? param}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    if (withToken) {
      try {
        final response = await OCRApi().api.dio.post<T>(
              path,
              data: formdata,
              options: Options(
                headers: {
                  "Authorization": "Bearer ${token!}",
                },
              ),
            );
        return _returnResponse(response);
      } on DioException catch (e) {
        print('eek ${e.response}');
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    } else {
      try {
        final response = await OCRApi().api.dio.post<T>(
              path,
              data: formdata,
            );
        return _returnResponse(response);
      } on DioException catch (e) {
        print('eek ${e.response}');
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    }
    // if (withToken) {
    //   SharedPreferences storage = await SharedPreferences.getInstance();
    //   String? token = storage.getString('token');
    //   try {
    //     final response = await OCRApi().api.dio.post<T>(path,
    //         queryParameters: param,
    //         options: Options(
    //           headers: {
    //             "Authorization": "Bearer ${token!}",
    //           },
    //           receiveTimeout: Constants.timeout,
    //           sendTimeout: Constants.timeout,
    //         ),
    //         data: formdata);
    //     return _returnResponse(response);
    //   } on DioException catch (e) {
    //     if (e.response!.statusCode! >= 500) {
    //       return _returnResponse(e.response!);
    //     } else {
    //       return e.response!;
    //     }
    //   }
    // } else {
    //   print('base url ${OCRApi().api.dio.options.baseUrl}');

    // }
  }

  Future put<T extends Object?>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? formdata,
      Map<String, dynamic>? param}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    if (withToken) {
      try {
        final response = await OCRApi().api.dio.put<T>(
              path,
              data: formdata,
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${token!}',
                },
                receiveTimeout: Constants.timeout,
                sendTimeout: Constants.timeout,
              ),
            );

        return _returnResponse(response);
      } on DioException catch (e) {
        print('eek $e');
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    } else {
      try {
        final response = await OCRApi().api.dio.put<T>(
              path,
              data: formdata,
              options: Options(
                  receiveTimeout: Constants.timeout,
                  sendTimeout: Constants.timeout),
            );

        return _returnResponse(response);
      } on DioException catch (e) {
        print('eek $e');
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    }
    // if (withToken) {
    //   SharedPreferences storage = await SharedPreferences.getInstance();
    //   String? token = storage.getString('token');
    //   try {
    //     final response = await OCRApi().api.dio.post<T>(path,
    //         queryParameters: param,
    //         options: Options(
    //           headers: {
    //             "Authorization": "Bearer ${token!}",
    //           },
    //           receiveTimeout: Constants.timeout,
    //           sendTimeout: Constants.timeout,
    //         ),
    //         data: formdata);
    //     return _returnResponse(response);
    //   } on DioException catch (e) {
    //     if (e.response!.statusCode! >= 500) {
    //       return _returnResponse(e.response!);
    //     } else {
    //       return e.response!;
    //     }
    //   }
    // } else {
    //   print('base url ${OCRApi().api.dio.options.baseUrl}');

    // }
  }
}

dynamic _returnResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      return response;
    case 201:
      return response;
    case 400:
      throw BadRequestException(response.data);
    case 401:
      throw UnauthorizedException(response.data['message']);
    case 403:
      throw ForbiddenException(response.data['message']);
    case 404:
      throw BadRequestException(response.data);
    case 500:
      throw FetchDataException('Internal Server Error');
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
  }
}

class AppException implements Exception {
  final String? details;

  AppException({this.details});

  @override
  String toString() {
    // return "[$code]: $message \n $details";
    return '$details';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
          details: details,
        );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
          details: details,
        );
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String? details)
      : super(
          details: details,
        );
}

class ForbiddenException extends AppException {
  ForbiddenException(String? details)
      : super(
          details: details,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
          details: details,
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
          details: details,
        );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
          details: details,
        );
}
