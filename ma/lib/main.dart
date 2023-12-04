import 'package:flutter/material.dart';
import 'screens/home_page.dart'; 

void main() {
  runApp(MyMovieApp());
}

class MyMovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Movie App',
      home: HomePage(), 
    );
  }
}
