import 'package:http/http.dart' as http;
import 'package:movies/src/models/actors_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apikey = "8f9d53c3b65557b5cd5d44aa4a88ab15";
  String _url = "api.themoviedb.org"; // Inicio de la url de petición a la API
  String _language = "es-ES";

  // Función get all movies
  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, "3/movie/now_playing", { // Url con el endpoint
      "api_key" : _apikey, // Argumentos
      "language" : _language
    });

    final response = await http.get(url); // Hacer la petición
    final decodedData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodedData["results"]); // Crear una lista de Movies con los datos recibidos
    return movies.items;
  }

  // Función get popular movies
  Future<List<Movie>> getPopular() async {
    final url = Uri.https(_url, "3/movie/popular", { // Url con el endpoint
      "api_key" : _apikey, // Argumentos
      "language" : _language
    });

    final response = await http.get(url); // Hacer la petición
    final decodedData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodedData["results"]); // Crear una lista de Movies con los datos recibidos
    return movies.items;
  }

  // Función get cast
  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, "3/movie/$movieId/credits", { // Url con el endpoint
      "api_key" : _apikey, // Argumentos
      "language" : _language
    });

    final response = await http.get(url); // Hacer la petición
    final decodedData = json.decode(response.body);
    final cast = new Cast.fromJsonList(decodedData["cast"]); // Crear una lista de actores con los datos recibidos
    return cast.items;
  }

  // Función search movie
  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, "3/search/movie", { // Url con el endpoint
      "api_key" : _apikey, // Argumentos
      "language" : _language,
      "query" : query
    });

    final response = await http.get(url); // Hacer la petición
    final decodedData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodedData["results"]); // Crear una lista de Movies con los datos recibidos
    return movies.items;
  }

}