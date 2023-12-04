import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../entities/user.dart';
import '../providers/user_provider.dart'; // Import UserProvider
import 'login_page.dart'; // Import LoginPage

class UserPage extends StatelessWidget {
  final User user;

  UserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Username: ${user.username}", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20), // Spacing
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    // Clear the user data
    Provider.of<UserProvider>(context, listen: false).clearUser();

    // Navigate back to the LoginPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
