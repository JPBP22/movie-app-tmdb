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
  List<String> recentSearches = []; // Store recent search titles
  bool isLoading = false;
  TextEditingController _searchController = TextEditingController();

  void performSearch(String query) async {
    if (query.isNotEmpty) {
      setState(() => isLoading = true);
      var results = await _tmdbService.searchMoviesTVShowsActors(query);
      setState(() {
        searchResults = results['results'];
        isLoading = false;
      });
    } else {
      setState(() {
        searchResults = [];
        isLoading = false;
      });
    }
  }

  void addToRecentSearches(String title) {
    if (!recentSearches.contains(title)) {
      setState(() {
        recentSearches.insert(0, title);
        if (recentSearches.length > 10) {
          recentSearches.removeRange(10, recentSearches.length);
        }
      });
    }
  }

  Widget _buildSearchResults() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (searchResults.isNotEmpty) {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          var result = searchResults[index];
          String title = result['title'] ?? result['name'];
          return ListTile(
            title: Text(title),
            onTap: () {
              // Add the title of the selected result to recent searches
              addToRecentSearches(title);
              // Implement navigation to FilmPage with the selected result
            },
          );
        },
      );
    } else if (recentSearches.isNotEmpty) {
      return ListView.builder(
        itemCount: recentSearches.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recentSearches[index]),
            onTap: () => performSearch(recentSearches[index]),
          );
        },
      );
    } else {
      return Center(child: Text("No recent searches"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: performSearch,
              decoration: InputDecoration(
                labelText: 'Search Movies, TV Shows, Actors',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    performSearch('');
                  },
                ),
              ),
            ),
            Expanded(child: _buildSearchResults()),
          ],
        ),
      ),
    );
  }
}
