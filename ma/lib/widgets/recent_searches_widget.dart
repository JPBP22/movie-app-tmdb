import 'package:flutter/material.dart';
import '../screens/film_page.dart';
import '../screens/actor_info_page.dart'; // Ensure this is correctly imported

class RecentSearch {
  final String title;
  final String imageUrl;
  final int? personId;
  final int filmId;
  final String mediaType;

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
            if (search.mediaType == 'person') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActorInfoPage(actorId: search.personId!),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilmPage(filmId: search.filmId, mediaType: search.mediaType),
                ),
              );
            }
          },
        );
      },
    );
  }
}
