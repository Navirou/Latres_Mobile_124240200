import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUsername = 'logged_username';
  
  // Default expected student NIM
  static const String expectedNIM = '124240200';
  static const String expectedPassword = '123';

  /// Check credentials and save session to SharedPreferences
  static Future<bool> login(String username, String password) async {
    final trimmedUser = username.trim();
    final trimmedPass = password.trim();

    // Check if credentials match: username is NIM and password is 123
    // We allow the user's confirmed NIM '124240200' or any valid numeric NIM
    if ((trimmedUser == expectedNIM || (trimmedUser.isNotEmpty && int.tryParse(trimmedUser) != null)) &&
        trimmedPass == expectedPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(keyIsLoggedIn, true);
      await prefs.setString(keyUsername, trimmedUser);
      return true;
    }
    return false;
  }

  /// Check whether user is currently logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  /// Get currently logged-in username
  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername) ?? expectedNIM;
  }

  /// Clear session and logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyIsLoggedIn);
    await prefs.remove(keyUsername);
  }
}
