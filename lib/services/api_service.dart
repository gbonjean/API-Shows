import 'dart:async';

import 'package:digital_paca_test/models/show.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://46.101.229.177:8080',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
  final _storage = const FlutterSecureStorage();
  final _authStateController = StreamController<bool>();
  String _token = '';
  get token => _token;

  ApiService() {
    _storage.read(key: 'refreshToken').then((value) {
      if (value != null) {
        _getTokenFromRefresh(value);
      } else {
        _authStateController.add(false);
      }
    });
  }

  _getTokenFromRefresh(String refreshToken) async {
    try {
      final response = await _dio
          .post('/auth/refresh', data: {'refreshToken': refreshToken});
      if (response.statusCode == 200) {
        _token = response.data['token'] as String;
        _authStateController.add(true);
      }
    } on DioException {
      _authStateController.add(false);
    }
  }

  Stream<bool> authState() {
    return _authStateController.stream;
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        _token = response.data['token'] as String;
        _authStateController.add(true);
        final refreshToken = response.data['refreshToken'] as String;
        _storage.write(key: 'refreshToken', value: refreshToken);
        return '';
      } else {
        return 'Identifiants incorrects !';
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return 'Identifiants incorrects !';
      } else {
        return 'Une erreur est survenue... Essayez plus tard !';
      }
    }
  }

  Future<void> logout() async {
    _token = '';
    _storage.delete(key: 'refreshToken');
    _authStateController.add(false);
  }

  Future<List<Show>> getShows() async {
    final response = await _dio.get('/series',
        options: Options(
          headers: {'Authorization': 'Bearer $_token'},
        ));
    if (response.statusCode == 200) {
      final shows = response.data as List<dynamic>;
      return shows
          .map((e) => Show.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}
