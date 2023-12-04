import 'package:flutter/material.dart';

class FilmInfoWidget extends StatelessWidget {
  final Map<String, dynamic> details;

  FilmInfoWidget({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Film Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10), // Space after title
        if (details.containsKey('director')) 
          infoRow('Director:', details['director']),
        if (details['genres'] != null && details['genres'].isNotEmpty) 
          infoRow('Genre:', details['genres'][0]['name']),
        if (details.containsKey('release_date') || details.containsKey('first_air_date'))
          infoRow('Release Date:', details['release_date'] ?? details['first_air_date']),
        if (details.containsKey('overview'))
          infoRow('Summary:', details['overview']),
        if (details.containsKey('runtime'))
          infoRow('Length:', '${details['runtime']} minutes'),
        if (details.containsKey('age_rating'))
          infoRow('PEGI:', details['age_rating']),
        SizedBox(height: 20), // Space at the bottom
      ],
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Spacing between rows
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: label, style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' $value'),
          ],
        ),
      ),
    );
  }
}
