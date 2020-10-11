import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_key.dart';



String userInput;
Map<String, dynamic> movies;
Map<String, dynamic> tvSeries;
Map<String, dynamic> movieDetails;
Map<String, dynamic> tvSeriesDetails;
Future response;
Future response1;

Future getSearchResultsMovie(String userInput) async{
  http.Response response=await http.get('https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$userInput&page=1');

  if(response.statusCode==200){
    movies=jsonDecode(response.body);
  }else{
    print(response.statusCode);
  }

}

Future getSearchResultsTv(String userInput) async{
  http.Response response=await http.get('https://api.themoviedb.org/3/search/tv?api_key=$apiKey&query=$userInput&page=1');

  if(response.statusCode==200){
    tvSeries=jsonDecode(response.body);
  }else{
    print(response.statusCode);
  }
}

Future getMovieDetails(String id) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US');
  if (response.statusCode == 200) {
    movieDetails = jsonDecode(response.body);
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
