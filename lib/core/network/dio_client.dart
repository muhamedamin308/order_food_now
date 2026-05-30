import 'package:dio/dio.dart';
import 'package:order_now/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api/',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      followRedirects: false,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
