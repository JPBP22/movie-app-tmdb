import 'package:flutter/material.dart';
import '../widgets/film_info_widget.dart';
import '../widgets/cast_info_widget.dart';
import '../widgets/rate_stars_widget.dart';
import '../widgets/add_to_watchlist_widget.dart';
import '../services/tmdb_service.dart';

class FilmPage extends StatefulWidget {
  final int filmId;
  final String mediaType;

  FilmPage({Key? key, required this.filmId, required this.mediaType}) : super(key: key);

  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  var filmDetails;
  List<dynamic> castDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilmData();
  }

  void fetchFilmData() async {
    filmDetails = await TMDBService().fetchFilmDetails(widget.filmId, widget.mediaType);
    var castResponse = await TMDBService().fetchCastDetails(widget.filmId, widget.mediaType);
    if (castResponse != null && castResponse is Map<String, dynamic>) {
      castDetails = castResponse['cast'];
    }

    filmDetails['director'] = await TMDBService().fetchDirector(widget.filmId);
    filmDetails['age_rating'] = await TMDBService().fetchPegiRating(widget.filmId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Film Details')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      filmDetails['title'] ?? filmDetails['name'], 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${filmDetails['poster_path']}', 
                      width: MediaQuery.of(context).size.width * 0.7
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Rating: ${formatRating(filmDetails['vote_average'])} ', 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                        Icon(Icons.star, color: Colors.yellow),
                      ],
                    ),
                  ),
                  Divider(),
                  CastInfoWidget(cast: castDetails),
                  Divider(),
                  FilmInfoWidget(details: filmDetails),
                  Divider(),
                  RateStarsWidget(itemId: widget.filmId.toString(), mediaType: widget.mediaType),
                  AddToWatchlistWidget(itemId: widget.filmId.toString(), mediaType: widget.mediaType),
                ],
              ),
            ),
    );
  }

  String formatRating(dynamic rating) {
    return (rating is double ? rating.toStringAsFixed(1) : rating.toString());
  }
}
