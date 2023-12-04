import 'package:flutter/material.dart';

class ActorInfoPage extends StatelessWidget {
  final int actorId;

  ActorInfoPage({Key? key, required this.actorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Actor Details')),
      body: Center(child: Text('Actor Info for ID: $actorId')),
    );
  }
}
