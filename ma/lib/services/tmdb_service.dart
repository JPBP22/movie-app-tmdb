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
}
