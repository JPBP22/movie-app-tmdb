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
      Map<String, dynamic> userMap = jsonDecode(userData);

      // Ensure moviesRated is correctly converted to a Map<String, double>
      if (userMap['moviesRated'] != null) {
        var moviesRated = userMap['moviesRated'];
        if (moviesRated is Map) {
          userMap['moviesRated'] = moviesRated.map<String, double>((key, value) => MapEntry(key, value.toDouble()));
        } else {
          // Handle the case where moviesRated is not a Map
          // Clearing or logging an error might be necessary here
          userMap['moviesRated'] = {};
        }
      }

      return User.fromMap(userMap);
    }

    return null;
  }

  Future<User?> loginUser(String username, String password) async {
    User? user = await getUser(username);

    if (user != null && user.password == password) {
      return user;
    }

    return null;
  }
}
