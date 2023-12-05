import 'package:http/http.dart' as http;
import 'dart:convert';

class TMDBService {
  final String apiKey = 'key';

    Future<dynamic> fetchTrendingMovies() async {
    var url = Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey');
    var response = await http.get(url);

    if (response.statusCode == 200) {
        return json.decode(response.body);
    } else {
        // Handle error
        print('Failed to load trending movies');
        }
    }

    Future<dynamic> fetchTrendingTVShows() async {
    var url = Uri.parse('https://api.themoviedb.org/3/trending/tv/week?api_key=$apiKey');
    var response = await http.get(url);

    if (response.statusCode == 200) {
        return json.decode(response.body);
    } else {
        // Handle error
        print('Failed to load trending TV shows');
    }
    }

    Future<dynamic> searchMoviesTVShowsActors(String query) async {
    var url = Uri.parse('https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=$query');
    var response = await http.get(url);

    if (response.statusCode == 200) {
        return json.decode(response.body);
    } else {
        print('Failed to search');
        }
    }

   Future<dynamic> fetchFilmDetails(int id, String type) async {
    var url = Uri.parse('https://api.themoviedb.org/3/$type/$id?api_key=$apiKey');
    var response = await http.get(url);

     if (response.statusCode == 200) {
        return json.decode(response.body);
     } else {
        print('Failed to load film details');
        }
    }    


    Future<dynamic> fetchCastDetails(int id, String type) async {
    var url = Uri.parse('https://api.themoviedb.org/3/$type/$id/credits?api_key=$apiKey');
    var response = await http.get(url);

    if (response.statusCode == 200) {
        return json.decode(response.body);
    } else {
        print('Failed to load cast details');
        }
    }

    Future<String> fetchDirector(int filmId) async {
    var url = Uri.parse('https://api.themoviedb.org/3/movie/$filmId/credits?api_key=$apiKey');
    var response = await http.get(url);

    if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var crew = data['crew'] as List<dynamic>;
        var director = crew.firstWhere((member) => member['job'] == 'Director', orElse: () => null);
        return director != null ? director['name'] : 'Unknown';
    } else {
        print('Failed to load director details');
        return 'Unknown';
            }
    }

    Future<String> fetchPegiRating(int filmId) async {
    var url = Uri.parse('https://api.themoviedb.org/3/movie/$filmId?api_key=$apiKey&language=en-US&append_to_response=release_dates');
    var response = await http.get(url);

    if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var releaseDates = data['release_dates'] as Map<String, dynamic>;
        // This part may vary depending on the structure of the release_dates response
        var certification = releaseDates['results']?.firstWhere((country) => country['iso_3166_1'] == 'US')['release_dates']?.first['certification'];
        return certification ?? 'Unknown';
    } else {
        print('Failed to load PEGI rating');
        return 'Unknown';
        }   
    }

      Future<dynamic> fetchActorDetails(int actorId) async {
    var url = Uri.parse('https://api.themoviedb.org/3/person/$actorId?api_key=$apiKey&append_to_response=movie_credits');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load actor details');
      return null;
    }
  }
}
