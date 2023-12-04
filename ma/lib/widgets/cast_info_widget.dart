import 'package:flutter/material.dart';
import '../screens/actor_info_page.dart'; // Import ActorInfoPage

class CastInfoWidget extends StatelessWidget {
  final List<dynamic> cast;

  CastInfoWidget({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cast.map((castMember) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActorInfoPage(actorId: castMember['id']),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${castMember['profile_path']}',
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                  ),
                  Text(castMember['name'], style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
