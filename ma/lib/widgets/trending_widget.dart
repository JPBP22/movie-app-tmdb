import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';

class TrendingWidget extends StatefulWidget {
  @override
  _TrendingWidgetState createState() => _TrendingWidgetState();
}

class _TrendingWidgetState extends State<TrendingWidget> {
  List<dynamic> trendingMovies = [];
  List<dynamic> trendingTVShows = [];

  @override
  void initState() {
    super.initState();
    fetchTrendingContent();
  }

  void fetchTrendingContent() async {
    var movies = await TMDBService().fetchTrendingMovies();
    var tvShows = await TMDBService().fetchTrendingTVShows();
    setState(() {
      trendingMovies = movies['results'];
      trendingTVShows = tvShows['results'];
    });
  }

  Widget buildScrollableGallery(List<dynamic> items) {
    int itemCount = 10000;  // Arbitrary large number for looping effect
    int initialPage = itemCount ~/ 2;  // Start in the middle of the range
    PageController controller = PageController(
      viewportFraction: 0.6,
      initialPage: initialPage,
    );

    return Container(
      height: 350, // Increased height to avoid overflow
      child: PageView.builder(
        controller: controller,
        itemCount: itemCount, // Looping effect
        itemBuilder: (context, index) {
          var item = items[index % items.length]; // Looping effect
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0), // Space between posters
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                double value = 1.0;
                if (controller.position.haveDimensions) {
                  double page = controller.page ?? index.toDouble();
                  value = page - index;
                  value = (1 - (value.abs() * .2)).clamp(0.8, 1.0);
                }
                double scale = Curves.easeOut.transform(value) * 0.4 + 1;
                return Center(
                  child: SizedBox(
                    height: scale * 250,
                    width: scale * 180,
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network('https://image.tmdb.org/t/p/w500${item['poster_path']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text('Trending Movies', style: TextStyle(fontSize: 18)),
          buildScrollableGallery(trendingMovies),
          SizedBox(height: 30),
          Text('Trending TV Shows', style: TextStyle(fontSize: 18)),
          buildScrollableGallery(trendingTVShows),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
