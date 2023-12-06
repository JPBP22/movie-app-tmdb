import 'package:flutter/material.dart';
import '../entities/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void rateMovie(String movieId, double rating) {
    _user?.moviesRated[movieId] = rating;
    notifyListeners();
  }

  void rateTVShow(String tvShowId, double rating) {
    _user?.tvShowsRated[tvShowId] = rating;
    notifyListeners();
  }

  void addToWatchlist(String movieId) {
    if (_user != null && !_user!.moviesToWatchList.contains(movieId)) {
      _user!.moviesToWatchList.add(movieId);
      notifyListeners();
    }
  }

  void removeFromWatchlist(String movieId) {
    if (_user != null && _user!.moviesToWatchList.contains(movieId)) {
      _user!.moviesToWatchList.remove(movieId);
      notifyListeners();
    }
  }

  void addToTVShowWatchlist(String tvShowId) {
    if (_user != null && !_user!.tvShowsToWatchList.contains(tvShowId)) {
      _user!.tvShowsToWatchList.add(tvShowId);
      notifyListeners();
    }
  }

  void removeFromTVShowWatchlist(String tvShowId) {
    if (_user != null && _user!.tvShowsToWatchList.contains(tvShowId)) {
      _user!.tvShowsToWatchList.remove(tvShowId);
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
