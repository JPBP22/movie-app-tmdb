class User {
  String username;
  String password;
  List<String> moviesToWatchList;
  List<String> tvShowsToWatchList; // New list for TV show watchlist
  Map<String, double> moviesRated;
  Map<String, double> tvShowsRated; // New map for TV show ratings
  List<String> subscribedServices;

  User({
    required this.username,
    required this.password,
    required this.moviesToWatchList,
    required this.tvShowsToWatchList, // Include in constructor
    required this.moviesRated,
    required this.tvShowsRated,
    required this.subscribedServices,
  });

  void addToWatchlist(String movieId) {
    if (!moviesToWatchList.contains(movieId)) {
      moviesToWatchList.add(movieId);
    }
  }

  void removeFromWatchlist(String movieId) {
    moviesToWatchList.remove(movieId);
  }

  void addToTVShowWatchlist(String tvShowId) { // New method for adding TV shows to watchlist
    if (!tvShowsToWatchList.contains(tvShowId)) {
      tvShowsToWatchList.add(tvShowId);
    }
  }

  void removeFromTVShowWatchlist(String tvShowId) { // New method for removing TV shows from watchlist
    tvShowsToWatchList.remove(tvShowId);
  }

  void rateMovie(String movieId, double rating) {
    moviesRated[movieId] = rating;
  }

  void rateTVShow(String tvShowId, double rating) {
    tvShowsRated[tvShowId] = rating;
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'moviesToWatchList': moviesToWatchList,
      'tvShowsToWatchList': tvShowsToWatchList, // Add to map conversion
      'moviesRated': moviesRated,
      'tvShowsRated': tvShowsRated,
      'subscribedServices': subscribedServices,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      moviesToWatchList: List<String>.from(map['moviesToWatchList'] ?? []),
      tvShowsToWatchList: List<String>.from(map['tvShowsToWatchList'] ?? []), // Add handling for TV show watchlist
      moviesRated: map['moviesRated'] != null
          ? Map<String, double>.from(map['moviesRated'])
          : {},
      tvShowsRated: map['tvShowsRated'] != null
          ? Map<String, double>.from(map['tvShowsRated'])
          : {},
      subscribedServices: List<String>.from(map['subscribedServices'] ?? []),
    );
  }
}
