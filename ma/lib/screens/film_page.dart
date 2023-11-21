import 'package:flutter/material.dart';
import '../widgets/film_info_widget.dart'; // Ensure this widget is defined
import '../widgets/cast_info_widget.dart'; // Cast Info Widget
import '../services/tmdb_service.dart'; // Your API services

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
    filmDetails['director'] = await TMDBService().fetchDirector(widget.filmId);
    filmDetails['age_rating'] = await TMDBService().fetchPegiRating(widget.filmId);

    // Fetch cast details and extract the cast list from the map
    var castResponse = await TMDBService().fetchCastDetails(widget.filmId, widget.mediaType);
    if (castResponse != null && castResponse is Map<String, dynamic>) {
      castDetails = castResponse['cast']; // Assuming the list is under the 'cast' key
    }

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
                children: [
                  Image.network('https://image.tmdb.org/t/p/w500${filmDetails['poster_path']}'),
                  Text(filmDetails['title'] ?? filmDetails['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Rating: ${filmDetails['vote_average']} / 10'),
                  if (castDetails != null) CastInfoWidget(cast: castDetails), // Pass the extracted cast list
                  FilmInfoWidget(details: filmDetails), // Custom widget for film info
                ],
              ),
            ),
    );
  }
}
