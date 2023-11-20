import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';

class TrendingWidget extends StatefulWidget {
  @override
  _TrendingWidgetState createState() => _TrendingWidgetState();
}

class _TrendingWidgetState extends State<TrendingWidget> {
  List<dynamic> trendingMovies = [];

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
  }

  void fetchTrendingMovies() async {
    var movies = await TMDBService().fetchTrendingMovies();
    if (movies != null) {
      setState(() {
        trendingMovies = movies['results'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trendingMovies.length,
      itemBuilder: (context, index) {
        var movie = trendingMovies[index];
        return ListTile(
          title: Text(movie['title']),
          // Display more information here as needed
        );
      },
    );
  }
}
