import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {

  Future<List<Peli>> getPelis() async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=78d1053ad20b601300e7eaa8e52698ec');
    final response = await http.get(url);

    if (response.statusCode == 200) {

      final cuerpo = jsonDecode(response.body);
      final pelis = cuerpo['results'] as List;

      return pelis.map((peli) => Peli.desdeJson(peli)).toList();
    } else {

      throw Exception('Error al obtener películas populares');
      
    }
  }

  getPelis().then((pelis) {
    for (final peli in pelis) {
      print(peli.titulo);
    }
  });
}

class Peli {
  final String titulo;

  Peli({
    required this.titulo,
  });

  factory Peli.desdeJson(Map<String, dynamic> json) {
    return Peli(
      titulo: json['title'],
    );
  }
}