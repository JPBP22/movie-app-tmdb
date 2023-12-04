import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import '../widgets/recent_searches_widget.dart';
import 'film_page.dart';
import 'actor_info_page.dart'; // Import ActorInfoPage

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

  void addToRecentSearches(String title, String imageUrl, int id, String mediaType) {
    var newSearch = RecentSearch(
      title: title,
      imageUrl: imageUrl,
      personId: mediaType == 'person' ? id : null,
      filmId: mediaType != 'person' ? id : 0, // 0 as a placeholder
      mediaType: mediaType,
    );

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
          itemCount: searchResults.length > 10 ? 10 : searchResults.length,
          itemBuilder: (context, index) {
            var result = searchResults[index];
            String title = result['title'] ?? result['name'] ?? 'Unknown';
            String imageUrl = 'https://image.tmdb.org/t/p/w500';
            int id = result['id'];
            String mediaType = result['media_type'];

            if (mediaType == 'person') {
              imageUrl += result['profile_path'] ?? '';
              return ListTile(
                title: Text(title),
                leading: _buildImage(imageUrl),
                onTap: () {
                  addToRecentSearches(title, imageUrl, id, mediaType);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActorInfoPage(actorId: id),
                    ),
                  );
                },
              );
            } else {
              imageUrl += result['poster_path'] ?? '';
              return ListTile(
                title: Text(title),
                leading: _buildImage(imageUrl),
                onTap: () {
                  addToRecentSearches(title, imageUrl, id, mediaType);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilmPage(filmId: id, mediaType: mediaType),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    } else {
      return SizedBox(); // Empty container when there are no search results
    }
  }

  Widget _buildImage(String url) {
    return Image.network(
      url,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
    );
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
            Divider(color: Colors.grey[300]),
            _buildSearchResults(),
            Divider(color: Colors.grey[300]),
            Text('Recent Searches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: RecentSearchesWidget(recentSearches: recentSearches),
            ),
          ],
        ),
      ),
    );
  }
}
