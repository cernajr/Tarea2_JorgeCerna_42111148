import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  // Obtener una lista de películas populares
  Future<List<Movie>> getPopularMovies() async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // La solicitud se realizó correctamente
      final body = jsonDecode(response.body);
      final movies = body['results'] as List;

      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      // La solicitud falló
      throw Exception('Error al obtener películas populares');
    }
  }

  // Mostrar la lista de películas populares
  getPopularMovies().then((movies) {
    for (final movie in movies) {
      print(movie.title);
    }
  });
}

class Movie {
  final String title;
  final String posterPath;
  final String releaseDate;

  Movie({
    required this.title,
    required this.posterPath,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
    );
  }
}