import 'package:flutter/material.dart';

class FilmInfoWidget extends StatelessWidget {
  final Map<String, dynamic> details;

  FilmInfoWidget({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Director: ${details['director']}', style: TextStyle(fontSize: 16)), // Assuming 'director' is a key in details
        Text('Genre: ${details['genres']?.first['name']}', style: TextStyle(fontSize: 16)), // Genres are usually a list
        if (details['type'] == 'tv') ...[
          Text('Seasons: ${details['number_of_seasons']}', style: TextStyle(fontSize: 16)),
          Text('Episodes: ${details['number_of_episodes']}', style: TextStyle(fontSize: 16)),
        ],
        Text('Release Date: ${details['release_date'] ?? details['first_air_date']}', style: TextStyle(fontSize: 16)), // For movie or TV
        Text('Summary: ${details['overview']}', style: TextStyle(fontSize: 16)),
        Text('Length: ${details['runtime']} minutes', style: TextStyle(fontSize: 16)), // For movies
        Text('PEGI: ${details['age_rating']}', style: TextStyle(fontSize: 16)), // Assuming 'age_rating' is a key
        // Add more fields as per your API response structure
      ],
    );
  }
}
