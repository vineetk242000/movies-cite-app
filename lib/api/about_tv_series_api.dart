import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_key.dart';


Map<String, dynamic> tvSeriesData;
Map<String, dynamic> crewData;
Map<String, dynamic> images;
Map<String, dynamic> recommendations;
Map<String, dynamic> recommendedTvSeriesDetails;
Future responseStatus;
Future responseStatus1;
Future responseStatus3;


Future getCastAndCrew(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/tv/$id/credits?api_key=$apiKey');
  if (response.statusCode == 200) {
    crewData = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getImages(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/tv/$id/images?api_key=$apiKey');
  if (response.statusCode == 200) {
    images = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getRecommendedTvSeries(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/tv/$id/recommendations?api_key=$apiKey&language=en-US&page=1');
  if (response.statusCode == 200) {
    recommendations = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getRecommendedTvSeriesDetails(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/tv/$id?api_key=$apiKey&language=en-US');
  if (response.statusCode == 200) {
    recommendedTvSeriesDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}
