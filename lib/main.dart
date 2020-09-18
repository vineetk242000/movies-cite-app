import 'package:flutter/material.dart';
import 'package:movies_app/screens/home.dart';
import 'package:movies_app/screens/search.dart';
import 'package:movies_app/screens/tvSeriesDetails.dart';
import 'package:flutter/services.dart';
import 'screens/about.dart';
import 'package:movies_app/screens/search_results.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),

      routes: {
        '/about':(context)=> About(),
        '/search':(context)=>SearchBar(),
        '/seriesDetails':(context)=>TvSeriesDetails(),
        '/searchResults':(context)=>Results()
      },
    );
  }
}
