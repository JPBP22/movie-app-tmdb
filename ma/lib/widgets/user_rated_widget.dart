import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../screens/film_page.dart';
import '../services/tmdb_service.dart';

class UserRatedWidget extends StatefulWidget {
  @override
  _UserRatedWidgetState createState() => _UserRatedWidgetState();
}

class _UserRatedWidgetState extends State<UserRatedWidget> {
  final TMDBService _tmdbService = TMDBService();
  Map<String, dynamic> _filmDetailsCache = {};

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final ratedItems = {
      ...userProvider.user?.moviesRated.keys.map((id) => {'id': id, 'type': 'movie'}) ?? [],
      ...userProvider.user?.tvShowsRated.keys.map((id) => {'id': id, 'type': 'tv'}) ?? [],
    };

    return ListView.builder(
      itemCount: ratedItems.length,
      itemBuilder: (context, index) {
        var item = ratedItems.elementAt(index);
        String id = item['id'] ?? '';
        String type = item['type'] ?? '';
        double rating = (type == 'movie' ? userProvider.user?.moviesRated[id] : userProvider.user?.tvShowsRated[id]) ?? 0;

        return FutureBuilder(
          future: _fetchFilmDetails(id, type),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              var filmData = snapshot.data as Map<String, dynamic>;
              return ListTile(
                leading: Image.network('https://image.tmdb.org/t/p/w500${filmData['poster_path']}'),
                title: Text(filmData['title'] ?? filmData['name']),
                subtitle: Text("Your Rating: $rating"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilmPage(filmId: int.parse(id), mediaType: type),
                    ),
                  );
                },
              );
            } else {
              return ListTile(
                title: Text("Loading..."),
                subtitle: Text("Your Rating: $rating"),
              );
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
