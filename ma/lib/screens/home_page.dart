import 'package:flutter/material.dart';
import '../widgets/trending_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Movies and TV Shows'),
      ),
      body: TrendingWidget(),
    );
  }
}
