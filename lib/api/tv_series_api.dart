import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_key.dart';
import '../screens/tv_series.dart';

Map<String, dynamic> popularTvSeriesList;
Map<String, dynamic> tvSeriesDetails;
Map<String, dynamic> nowPlayingTvSeries;
List<Map> carouselImages = [];

Future getPopularTvSeries() async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&language=en-US&page=$pageNumber');
  if (response.statusCode == 200) {
    popularTvSeriesList = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getTvSeriesDetails(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/tv/$id?api_key=$apiKey&language=en-US');
  if (response.statusCode == 200) {
    tvSeriesDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getNowPlayingTvSeries() async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apiKey&language=en-US&page=1');
  if (response.statusCode == 200) {
    nowPlayingTvSeries = jsonDecode(response.body);
    carouselImages = [
      for(var i=0;i<nowPlayingTvSeries['results'].length;i++)
        {
          'path':'${nowPlayingTvSeries['results'][i]['poster_path']}',
          'id':'${nowPlayingTvSeries['results'][i]['id']}',
        },
    ];
  } else {
    print(response.statusCode);
  }
}