import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/user.dart'; 

class AuthService {
  Future<bool> createUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(user.username) != null) {
      return false; // User already exists
    }

    String userData = jsonEncode(user.toMap());
    prefs.setString(user.username, userData);
    return true;
  }

  Future<User?> getUser(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString(username);

    if (userData != null) {
      return User.fromMap(jsonDecode(userData));
    }

    return null;
  }

  // Update loginUser to return User instead of bool
  Future<User?> loginUser(String username, String password) async {
    User? user = await getUser(username);

    if (user != null && user.password == password) {
      return user;
    }

    return null;
  }
}
