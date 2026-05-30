import 'package:dio/dio.dart';
import 'package:order_now/core/network/api_error.dart';
import 'package:order_now/core/network/api_exceptions.dart';
import 'package:order_now/core/network/api_service.dart';
import 'package:order_now/core/utils/pref_helper.dart';
import 'package:order_now/features/auth/data/model/user_model.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();
  // login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await _apiService.post('login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) throw response;
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];
        final isSuccess = code == 200 || code == 201;
        if (!isSuccess || data == null) {
          throw ApiError(message: msg);
        }
        final user = UserModel.fromJson(response['data']);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: 'Unexpected error occured');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<UserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.post('register', {
        'name': name,
        'email': email,
        'password': password,
      });
      if (response is ApiError) throw response;
      if (response is Map<String, dynamic>) {
        final msg = response['message'] as String? ?? 'Something went wrong';
        final rawCode = response['code'];
        final code = rawCode is int
            ? rawCode
            : int.tryParse(rawCode?.toString() ?? '');
        final data = response['data'];
        final isSuccess = code == 200 || code == 201;
        if (!isSuccess || data == null) {
          throw ApiError(message: msg);
        }
        final user = UserModel.fromJson(response['data']);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: 'Unexpected error occured');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
