import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetails extends StatefulWidget {
  @override
  _TvSeriesDetailsState createState() => _TvSeriesDetailsState();
}

class _TvSeriesDetailsState extends State<TvSeriesDetails> {

  Map<String, dynamic> tvSeriesData;
  Map<String, dynamic> crewData;
  Map<String, dynamic> images;
  Map<String, dynamic> recommendations;
  Future responseStatus;
  Future responseStatus1;
  Future responseStatus3;

  Future getCastAndCrew(String id) async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/tv/$id/credits?api_key=5a945992366721e6b76a83e296616bf8');
    if (response.statusCode == 200) {
      crewData = jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getImages(String id) async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/tv/$id/images?api_key=5a945992366721e6b76a83e296616bf8');
    if (response.statusCode == 200) {
      images = jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getRecommendedTvSeries(String id) async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/tv/$id/recommendations?api_key=5a945992366721e6b76a83e296616bf8&language=en-US&page=1');
    if (response.statusCode == 200) {
      recommendations = jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) tvSeriesData= arguments;
    responseStatus = getCastAndCrew(tvSeriesData['id'].toString());
    responseStatus1 = getImages(tvSeriesData['id'].toString());
    responseStatus3 = getRecommendedTvSeries(tvSeriesData['id'].toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100.0),
        child: SafeArea(
          child: Container(
            height: 100.0,
            padding: EdgeInsets.only(
                top: 8.0, left: 10.0, right: 10.0, bottom: 10.0),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back),
                SizedBox(width: 20.0),
                Row(
                  children: [
                    Image.asset('images/film.png',height: 40.0),
                    SizedBox(width: 10.0),
                    Text(
                      'Movies Cite',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150.0,
                    width: 120.0,
                    margin:
                    EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x66808080),
                              spreadRadius: 2.0,
                              offset: Offset(3.0, 3.0)),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w185/${tvSeriesData['poster_path']}',
                        width: 120.0,
                        height: 150.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tvSeriesData['name']}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          height: 2.2,
                        ),
                      ),
                      Row(
                        children: [
                          RatingBar(
                            initialRating: (tvSeriesData['vote_average'])/2,
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
                              size: 1.0,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '${tvSeriesData['vote_average']}',
                            style:
                            TextStyle(fontFamily: 'Ubuntu', fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < tvSeriesData['genres'].length; i++)
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                child: Text(
                                  '${tvSeriesData['genres'][i]['name']}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                      height: 2.0),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        '${tvSeriesData['number_of_seasons']} seasons',
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.grey, height: 2.0),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Episodes', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 5.0),
                        Text(
                          '${tvSeriesData['number_of_episodes']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Aired', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 5.0),
                        Text(
                          '${tvSeriesData['last_air_date']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Likes', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 5.0),
                        Text(
                          '${tvSeriesData['vote_count']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Synopsis',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  Text(
                    '${tvSeriesData['overview']}',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Colors.black54,
                        height: 1.5,
                        fontSize: 16.0),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Crew & Cast',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    height: 250.0,
                    width: double.infinity,
                    child: FutureBuilder(
                        future: responseStatus,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var i = 0;
                                i < crewData['cast'].length;
                                i++)
                                  Container(
                                    width: 140.0,
                                    margin:
                                    EdgeInsets.only(left: 8.0, right: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: Color(0x80D3D3D3),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 140.0,
                                          height: 170.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(7.0),
                                                topRight: Radius.circular(7.0)),
                                            child: Image.network(
                                              'https://image.tmdb.org/t/p/w185/${crewData['cast'][i]['profile_path']}',
                                              width: 140.0,
                                              height: 170.0,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Text('${crewData['cast'][i]['name']}',
                                            style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(height: 5.0),
                                        Text(
                                            '${crewData['cast'][i]['character']}'),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          }
                          return Center(
                            child: SizedBox(
                              height: 100.0,
                              width: 100.0,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gallery',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        height: 2.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    height: 250.0,
                    width: double.infinity,
                    child: FutureBuilder(
                        future: responseStatus1,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return
                              ListView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                children: [
                                  for(var i=0;i<images['backdrops'].length;i++)
                                    Container(
                                      margin: EdgeInsets.all(10.0),
                                      height: 200.0,
                                      width: 350.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w1280/${images['backdrops'][i]['file_path']}',
                                          width: 350.0,
                                          height: 200.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                          }
                          return Center(
                            child: SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: CircularProgressIndicator()),
                          );
                        }),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recommended',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    height: 250.0,
                    width: double.infinity,
                    child: FutureBuilder(
                        future: responseStatus3,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var i = 0;
                                i < recommendations['results'].length;
                                i++)
                                  GestureDetector(
                                    onTap: () async{
                                      await getRecommendedTvSeries(recommendations['results'][i]['id']);
                                    },
                                    child: Container(
                                      width: 140.0,
                                      margin:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7.0),
                                        color: Color(0x80D3D3D3),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 140.0,
                                            height: 170.0,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(7.0),
                                                  topRight: Radius.circular(7.0)),
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w185/${recommendations['results'][i]['poster_path']}',
                                                width: 140.0,
                                                height: 170.0,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text('${recommendations['results'][i]['name']}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }
                          return Center(
                            child: SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

