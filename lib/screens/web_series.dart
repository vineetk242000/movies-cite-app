import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/genres.dart';


class WebSeries extends StatefulWidget {
  @override
  _WebSeriesState createState() => _WebSeriesState();
}

class _WebSeriesState extends State<WebSeries> {
  Map<String, dynamic> popularTvSeriesList;
  Map<String, dynamic> tvSeriesDetails;
  Map<String, dynamic> nowPlayingTvSeries;
  List<Map> carouselImages = [];

  Future getPopularTvSeries() async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/tv/popular?api_key=5a945992366721e6b76a83e296616bf8&language=en-US&page=1');
    if (response.statusCode == 200) {
      popularTvSeriesList = jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getTvSeriesDetails(String id) async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/tv/$id?api_key=5a945992366721e6b76a83e296616bf8&language=en-US');
    if (response.statusCode == 200) {
      tvSeriesDetails = jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getNowPlayingTvSeries() async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/tv/on_the_air?api_key=5a945992366721e6b76a83e296616bf8&language=en-US&page=1');
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


  @override
  void initState() {
    getPopularTvSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: getNowPlayingTvSeries(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            reverse: true,
                            enlargeCenterPage: true,
                            autoPlayInterval: Duration(seconds: 3),
                            height: 250,
                          ),
                          items: carouselImages
                              .map(
                                (i) => GestureDetector(
                              onTap: () async{
                                await getTvSeriesDetails(i['id']);
                                Navigator.pushNamed(context, '/seriesDetails',arguments: tvSeriesDetails);
                              },
                              child: Container(
                                height: 200.0,
                                width: 350.0,
                                margin: EdgeInsets.only(left:10.0,right:10.0,bottom: 30.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w1280/${i['path']}',
                                    height: 200.0,
                                    width: 350.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          )
                              .toList());
                    }
                    return Center(
                      child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
              FutureBuilder(
                  future: getPopularTvSeries(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          children: [
                            for (var i = 0; i < 20; i++)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      await getTvSeriesDetails(popularTvSeriesList['results'][i]['id'].toString());
                                      Navigator.pushNamed(context, '/seriesDetails',arguments: tvSeriesDetails);
                                    },
                                    child: Container(
                                      height: 150.0,
                                      width: 120.0,
                                      margin: EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 10.0,
                                          right: 20.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 4.0,
                                                color: Color(0x66808080),
                                                spreadRadius: 2.0,
                                                offset: Offset(3.0, 3.0)),
                                          ]),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(20.0),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w185/${popularTvSeriesList['results'][i]['poster_path']}',
                                          width: 120.0,
                                          height: 150.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${popularTvSeriesList['results'][i]['name']}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              RatingBar(
                                                initialRating: (popularTvSeriesList['results'][i]['vote_average'])/2,
                                                itemSize: 25.0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(
                                                    horizontal: 0.5, vertical: 2.5),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.yellow[800],
                                                  size: 2.0,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text('${popularTvSeriesList['results'][i]['vote_average']}',style: TextStyle(fontFamily: 'Ubuntu',fontSize: 16.0),)
                                            ],
                                          ),
                                          Container(
                                            height:20.0,
                                            margin:EdgeInsets.only(top:10.0,bottom:10.0),
                                            child: ListView(
                                              scrollDirection:Axis.horizontal,
                                              children: [
                                                for (var j = 0;j < popularTvSeriesList['results'][i]['genre_ids'].length;j++)
                                                  Container(
                                                    margin:EdgeInsets.only(right:10.0),
                                                    child: Text(
                                                      '${getMovieGenre(popularTvSeriesList['results'][i]['genre_ids'][j])}',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '${popularTvSeriesList['results'][i]['first_air_date'].toString().substring(0,4)}',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey,
                                                height: 2.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    }
                    return Center(
                        child: SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: CircularProgressIndicator()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
