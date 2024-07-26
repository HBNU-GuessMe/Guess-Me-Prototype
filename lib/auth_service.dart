import 'package:shared_preferences/shared_preferences.dart';
import 'shared_data.dart';

class AuthService {
  String? token = AccessTokenManager().accessToken;
  static const String _accessTokenKey = 'accessToken';

  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
  }
}
