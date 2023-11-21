import 'package:flutter/material.dart';
import '../screens/film_page.dart';

class RecentSearch {
  final String title;
  final String imageUrl;
  final int? personId;
  final int filmId;  // Added filmId to identify the movie/TV show
  final String mediaType; // Added mediaType to distinguish between movie and tv

  RecentSearch({
    required this.title,
    required this.imageUrl,
    this.personId,
    required this.filmId,
    required this.mediaType,
  });
}

class RecentSearchesWidget extends StatelessWidget {
  final List<RecentSearch> recentSearches;

  RecentSearchesWidget({Key? key, required this.recentSearches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) {
      return Center(child: Text("No recent searches"));
    }

    return ListView.builder(
      itemCount: recentSearches.length,
      itemBuilder: (context, index) {
        var search = recentSearches[index];
        return ListTile(
          title: Text(search.title),
          leading: Image.network(
            search.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          onTap: () {
            // Navigate to FilmPage with the filmId and mediaType
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilmPage(filmId: search.filmId, mediaType: search.mediaType),
              ),
            );
          },
        );
      },
    );
  }
}
