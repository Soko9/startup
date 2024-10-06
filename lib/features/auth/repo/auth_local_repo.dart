import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalRepo {
  final SharedPreferences _sharedPreferences;
  const AuthLocalRepo({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  static const String _tokenKey = "auth-token";

  Future<void> setToken({String? token}) async {
    if (token != null) {
      await _sharedPreferences.setString(_tokenKey, token);
    }
  }

  String? getToken() {
    return _sharedPreferences.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    await _sharedPreferences.remove(_tokenKey);
  }
}
