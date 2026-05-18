import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _cartTokenKey = 'woo_cart_token';

  Future<void> saveCartToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartTokenKey, token);
  }

  Future<String?> readCartToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cartTokenKey);
  }
}
