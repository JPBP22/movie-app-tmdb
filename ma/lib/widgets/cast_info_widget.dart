import 'package:flutter/material.dart';

class CastInfoWidget extends StatelessWidget {
  final List<dynamic> cast;

  CastInfoWidget({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cast.map((castMember) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network('https://image.tmdb.org/t/p/w500${castMember['profile_path']}', height: 100),
                Text(castMember['name'], style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
