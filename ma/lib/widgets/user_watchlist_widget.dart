import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../screens/film_page.dart';
import '../services/tmdb_service.dart';

class UserWatchlistWidget extends StatefulWidget {
  @override
  _UserWatchlistWidgetState createState() => _UserWatchlistWidgetState();
}

class _UserWatchlistWidgetState extends State<UserWatchlistWidget> {
  final TMDBService _tmdbService = TMDBService();
  Map<String, dynamic> _filmDetailsCache = {};

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final watchlistMovies = userProvider.user?.moviesToWatchList ?? [];
    final watchlistTVShows = userProvider.user?.tvShowsToWatchList ?? [];

    return ListView.builder(
      itemCount: watchlistMovies.length + watchlistTVShows.length,
      itemBuilder: (context, index) {
        bool isMovie = index < watchlistMovies.length;
        String itemId = isMovie ? watchlistMovies[index] : watchlistTVShows[index - watchlistMovies.length];
        String mediaType = isMovie ? 'movie' : 'tv';

        return FutureBuilder(
          future: _fetchFilmDetails(itemId, mediaType),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              var filmData = snapshot.data as Map<String, dynamic>;
              return ListTile(
                leading: Image.network('https://image.tmdb.org/t/p/w500${filmData['poster_path']}'),
                title: Text(filmData['title'] ?? filmData['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilmPage(filmId: int.parse(itemId), mediaType: mediaType),
                    ),
                  );
                },
              );
            } else {
              return ListTile(title: Text("Loading..."));
            }
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> _fetchFilmDetails(String id, String type) async {
    if (!_filmDetailsCache.containsKey(id)) {
      var details = await _tmdbService.fetchFilmDetails(int.parse(id), type);
      _filmDetailsCache[id] = details;
    }
    return _filmDetailsCache[id];
  }
}
