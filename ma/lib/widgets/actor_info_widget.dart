import 'package:flutter/material.dart';

class ActorInfoWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String age; // This will be a string for simplicity

  ActorInfoWidget({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              )
            : Icon(Icons.person, size: 100),
        Text(name, style: TextStyle(fontSize: 24)),
        Text('Age: $age'),
      ],
    );
  }
}
