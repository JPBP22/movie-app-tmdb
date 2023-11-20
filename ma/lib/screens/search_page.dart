import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import 'film_page.dart';  // Import the FilmPage

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TMDBService _tmdbService = TMDBService();
  List<dynamic> searchResults = [];
  List<String> recentSearches = []; // Placeholder for recent searches
  bool isLoading = false; // Define isLoading as a state variable

  void performSearch(String query) async {
    if (query.isNotEmpty) {
      setState(() => isLoading = true); // Indicate loading
      var results = await _tmdbService.searchMoviesTVShowsActors(query);
      setState(() {
        searchResults = results['results'];
        isLoading = false; // Loading complete
        // Optionally update recent searches here
      });
    }
  }

  Widget _buildSearchResults() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          var result = searchResults[index];
          return ListTile(
            title: Text(result['title'] ?? result['name']),
            onTap: () {
              // Implement navigation to FilmPage
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Column(
        children: [
          TextField(
            onSubmitted: performSearch,
            decoration: InputDecoration(
              labelText: 'Search Movies, TV Shows, Actors',
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(child: _buildSearchResults()), // Display search results
        ],
      ),
    );
  }
}
