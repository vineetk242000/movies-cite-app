import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../api/about_movie_api.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    setState(() {
      if (arguments != null) movieData = arguments;
    });
    responseStatus = getCastAndCrew(movieData['id'].toString());
    responseStatus1 = getMovieImages(movieData['id'].toString());
    responseStatus3 = getRecommendedMovies(movieData['id'].toString());

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
            child:Row(
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
                        'https://image.tmdb.org/t/p/w185/${movieData['poster_path']}',
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
                        '${movieData['title']}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          height: 2.2,
                        ),
                      ),
                      Row(
                        children: [
                          RatingBar(
                            initialRating: (movieData['vote_average'])/2,
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
                            '${movieData['vote_average']}',
                            style:
                                TextStyle(fontFamily: 'Ubuntu', fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < movieData['genres'].length && i<3; i++)
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              clipBehavior: Clip.none,
                              child: Text(
                                '${movieData['genres'][i]['name']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    height: 2.0),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        '${movieData['runtime']} min',
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
                        Text('Budget', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 5.0),
                        Text(
                          '${movieData['budget'].toString().replaceAllMapped(
                            new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Released', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 5.0),
                        Text(
                          '${movieData['release_date']}',
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
                          '${movieData['vote_count']}',
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
                    '${movieData['overview']}',
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
                                        SizedBox(height: 5.0),
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
                              height: 50.0,
                              width: 50.0,
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
                                for(var i=0;i<movieImages['backdrops'].length;i++)
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  height: 200.0,
                                  width: 350.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w1280/${movieImages['backdrops'][i]['file_path']}',
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
                                height: 50.0,
                                width: 50.0,
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
                                     await getRecommendedMovieDetails(recommendations['results'][i]['id'].toString());
                                     Navigator.pushReplacementNamed(context, '/about',arguments: recommendedMovieDetails);
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
                                          Text('${recommendations['results'][i]['title']}',
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
