import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import '../widgets/actor_info_widget.dart';
import '../widgets/actor_movies_widget.dart';

class ActorInfoPage extends StatefulWidget {
  final int actorId;

  ActorInfoPage({Key? key, required this.actorId}) : super(key: key);

  @override
  _ActorInfoPageState createState() => _ActorInfoPageState();
}

class _ActorInfoPageState extends State<ActorInfoPage> {
  final TMDBService _tmdbService = TMDBService();
  Map<String, dynamic>? actorDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchActorDetails();
  }

  void _fetchActorDetails() async {
    var details = await _tmdbService.fetchActorDetails(widget.actorId);
    if (details != null) {
      setState(() {
        actorDetails = details;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Actor Details')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (actorDetails == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Actor Details')),
        body: Center(child: Text('Actor details not found.')),
      );
    }

    // Calculating age (for simplicity, not considering birth date)
    String age = 'Unknown'; // Replace with actual age calculation if birth date is available

    return Scaffold(
      appBar: AppBar(title: Text('Actor Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActorInfoWidget(
              name: actorDetails!['name'],
              imageUrl: 'https://image.tmdb.org/t/p/w500${actorDetails!['profile_path']}',
              age: age,
            ),
            SizedBox(height: 20),
            Text('Movies/Shows:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ActorMoviesWidget(movies: actorDetails!['movie_credits']['cast']),
          ],
        ),
      ),
    );
  }
}
