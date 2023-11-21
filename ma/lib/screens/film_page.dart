import 'package:flutter/material.dart';
import '../widgets/film_info_widget.dart';
import '../widgets/cast_info_widget.dart';
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
  var castDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilmData();
  }

  void fetchFilmData() async {
    filmDetails = await TMDBService().fetchFilmDetails(widget.filmId, widget.mediaType);
    castDetails = await TMDBService().fetchCastDetails(widget.filmId, widget.mediaType);
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
                  Text(filmDetails['title'] ?? filmDetails['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Center(
                    child: Image.network('https://image.tmdb.org/t/p/w500${filmDetails['poster_path']}', width: MediaQuery.of(context).size.width * 0.7),
                  ),
                  Text('Rating: ${formatRating(filmDetails['vote_average'])} / 10'),
                  Divider(),
                  CastInfoWidget(cast: castDetails),
                  Divider(),
                  FilmInfoWidget(details: filmDetails),
                ],
              ),
            ),
    );
  }

  String formatRating(dynamic rating) {
    return (rating is double ? rating.toStringAsFixed(1) : rating.toString());
  }
}
