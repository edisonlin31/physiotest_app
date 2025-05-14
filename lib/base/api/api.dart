import 'package:dio/dio.dart';

import '../utils/logger.dart';

const String unkownErrorMsg = 'unknown error occurred';

class Api {
  static final Api _instance = Api._internal();
  final Dio dio = Dio();

  Api._internal() {
    initialize();
  }

  void initialize() async {
    dio.interceptors.add(MyInterceptor());
  }

  static Dio get client => _instance.dio;
}

class MyInterceptor extends Interceptor {
  _log(String url, [dynamic data]) {
    logger.i(url);
    if (data != null) {
      if (data is Map && data.isEmpty) {
        return;
      }
      logger.d(data);
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    _log("=> ${options.method} ${options.uri.toString()}", options.data);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final result = response.data;
    _log(
      "<= ${response.requestOptions.method} ${response.requestOptions.uri.toString()}",
      result,
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(err);
    Response<dynamic>? response = err.response;
    _log(
      "<= ${err.requestOptions.method} ${err.requestOptions.uri.toString()}",
      response?.data,
    );
    if (response != null && response.data is Map<String, dynamic>) {
      Map result = response.data;
      if (result.containsKey('error')) {
        err = err.copyWith(message: result['error']);
      }
    } else {
      if (response != null) {
        switch (response.statusCode) {
          case 500:
            err = err.copyWith(message: 'Please check your connection.');
            break;
          case 404:
            err = err.copyWith(message: 'Resource not found.');
            break;
          case 401:
            err = err.copyWith(message: 'Unauthorized access.');
            break;
          default:
            err = err.copyWith(message: 'An unexpected error occurred.');
        }
      } else {
        err = err.copyWith(message: 'An unexpected error occurred.');
      }
    }
    super.onError(err, handler);
  }
}
