import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import '../widgets/recent_searches_widget.dart';
import 'film_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TMDBService _tmdbService = TMDBService();
  List<dynamic> searchResults = [];
  List<RecentSearch> recentSearches = [];
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

  void addToRecentSearches(String title, String imageUrl, int filmId, String mediaType) {
    var newSearch = RecentSearch(title: title, imageUrl: imageUrl, filmId: filmId, mediaType: mediaType);
    if (!recentSearches.any((rs) => rs.title == newSearch.title && rs.imageUrl == newSearch.imageUrl)) {
      setState(() {
        recentSearches.insert(0, newSearch);
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
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: searchResults.length > 10 ? 10 : searchResults.length,
          itemBuilder: (context, index) {
            var result = searchResults[index];
            String title = result['title'] ?? result['name'];
            String imageUrl = 'https://image.tmdb.org/t/p/w500${result['poster_path']}';
            int filmId = result['id'];
            String mediaType = result.containsKey('title') ? 'movie' : 'tv';

            return ListTile(
              title: Text(title),
              leading: Image.network(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
              onTap: () {
                addToRecentSearches(title, imageUrl, filmId, mediaType);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilmPage(filmId: filmId, mediaType: mediaType),
                  ),
                );
              },
            );
          },
        ),
      );
    } else {
      return SizedBox(); // Empty container when there are no search results
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
            Divider(color: Colors.grey[300]), // For visual separation
            _buildSearchResults(),
            Divider(color: Colors.grey[300]), // For visual separation
            Text('Recent Searches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: RecentSearchesWidget(
                recentSearches: recentSearches,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
