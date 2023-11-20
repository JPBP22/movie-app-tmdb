import 'package:flutter/material.dart';
import '../widgets/trending_widget.dart';
import 'search_page.dart'; // Import the SearchPage

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              // Handle login/signup navigation
            },
          )
        ],
      ),
      body: TrendingWidget(),
    );
  }
}
