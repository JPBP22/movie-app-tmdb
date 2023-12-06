import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart'; // Import UserProvider
import '../widgets/trending_widget.dart';
import 'search_page.dart';
import 'login_page.dart';
import 'user_page.dart'; // Import UserPage

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the user from UserProvider
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    // Redirect to login page if no user is found
    if (user == null) {
      return LoginPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to UserPage without passing the user object
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
              );
            },
          ),
        ],
      ),
      body: TrendingWidget(),
    );
  }
}
