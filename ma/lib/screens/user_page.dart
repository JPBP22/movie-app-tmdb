import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user_rated_widget.dart';
import '../widgets/user_watchlist_widget.dart';
import 'login_page.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user == null) {
      return LoginPage(); // Redirect to login page if no user is found
    }

    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Username: ${user.username}", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text("Your Rated Movies", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 200,
              child: UserRatedWidget(),
            ),
            SizedBox(height: 20),
            Text("Your Watchlist", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 200,
              child: UserWatchlistWidget(),
            ),
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
    Provider.of<UserProvider>(context, listen: false).clearUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
