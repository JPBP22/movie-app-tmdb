import 'package:flutter/material.dart';
import '../screens/film_page.dart';

class ActorMoviesWidget extends StatelessWidget {
  final List<dynamic> movies;

  ActorMoviesWidget({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // To prevent inner list scrolling
      itemCount: movies.length, // Set itemCount to the length of the movies list
      itemBuilder: (context, index) {
        var movie = movies[index];
        return ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          title: Text(movie['title'] ?? movie['name']),
          subtitle: Text(movie['release_date'] ?? 'Unknown'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilmPage(filmId: movie['id'], mediaType: 'movie'),
              ),
            );
          },
        );
      },
    );
  }
}
