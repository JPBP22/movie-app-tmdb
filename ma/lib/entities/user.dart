class User {
  String username;
  String password;
  List<String> moviesToWatchList;
  List<String> moviesRated;
  List<String> subscribedServices;

  User({
    required this.username,
    required this.password,
    required this.moviesToWatchList,
    required this.moviesRated,
    required this.subscribedServices,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'moviesToWatchList': moviesToWatchList,
      'moviesRated': moviesRated,
      'subscribedServices': subscribedServices,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      moviesToWatchList: List<String>.from(map['moviesToWatchList'] ?? []),
      moviesRated: List<String>.from(map['moviesRated'] ?? []),
      subscribedServices: List<String>.from(map['subscribedServices'] ?? []),
    );
  }
}
