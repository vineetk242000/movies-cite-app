import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_key.dart';



Map<String, dynamic> movieData;
Map<String, dynamic> crewData;
Map<String, dynamic> movieImages;
Map<String, dynamic> recommendations;
Map<String, dynamic> recommendedMovieDetails;
Future responseStatus;
Future responseStatus1;
Future responseStatus3;

Future getCastAndCrew(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey');
  if (response.statusCode == 200) {
    crewData = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getMovieImages(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/movie/$id/images?api_key=$apiKey');
  if (response.statusCode == 200) {
    movieImages = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getRecommendedMovies(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/movie/$id/recommendations?api_key=$apiKey&language=en-US&page=1');
  if (response.statusCode == 200) {
    recommendations = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getRecommendedMovieDetails(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US');
  if (response.statusCode == 200) {
    recommendedMovieDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}