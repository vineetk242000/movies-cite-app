import 'package:movies_app/genres.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../api/search_results_api.dart';


class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {



  @override
  Widget build(BuildContext context) {

    final String arguments = ModalRoute.of(context).settings.arguments as String;

    if (arguments != null) userInput = arguments;
    response=getSearchResultsMovie(userInput);
    response1=getSearchResultsTv(userInput);

    return Scaffold(
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.only(left: 8.0,right: 8.0),
         child: SearchResultsPageView(),
       ),
     ),

    );
  }
}


class SearchResultsPageView extends StatefulWidget {
  @override
  _SearchResultsPageViewState createState() => _SearchResultsPageViewState();
}

class _SearchResultsPageViewState extends State<SearchResultsPageView> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: [
        Movies(),
        TvSeries(),
      ],
    );
  }
}

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.0,
          width: double.infinity,
          child: Center(child: Text('Search Results (Movies)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,fontFamily: 'Ubuntu'),)),
        ),
        FutureBuilder(
            future: response,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if(movies!=null){
                  return Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      children: [
                        for (var i = 0; i < movies['results'].length; i++)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  await getMovieDetails(movies['results'][i]['id'].toString());
                                  Navigator.pushNamed(context, '/about',arguments: movieDetails);
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
                                      'https://image.tmdb.org/t/p/w185/${movies['results'][i]['poster_path']}',
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
                                        '${movies['results'][i]['title']}',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          RatingBar(
                                            initialRating: (movies['results'][i]['vote_average'])/2,
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
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text('${movies['results'][i]['vote_average']}',style: TextStyle(fontFamily: 'Ubuntu',fontSize: 16.0),)
                                        ],
                                      ),
                                      Container(
                                        height:20.0,
                                        margin:EdgeInsets.only(top:10.0,bottom:10.0),
                                        child: ListView(
                                          scrollDirection:Axis.horizontal,
                                          children: [
                                            for (var j = 0;j < movies['results'][i]['genre_ids'].length;j++)
                                              Container(
                                                margin:EdgeInsets.only(right:10.0),
                                                child: Text(
                                                  '${getMovieGenre(movies['results'][i]['genre_ids'][j])}',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${movies['results'][i]['release_date']}',
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
                }else{
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No Results Found in Movies Categories',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  );
                }
              }
              return Center(
                  child: SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: CircularProgressIndicator()));
            }),
      ],
    );
  }
}

class TvSeries extends StatefulWidget {
  @override
  _TvSeriesState createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.0,
          width: double.infinity,
          child: Center(child: Text('Search Results (Tv)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,fontFamily: 'Ubuntu'),)),
        ),
        FutureBuilder(
            future: response1,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    children: [
                      for (var i = 0; i < tvSeries['results'].length; i++)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async{
                                await getTvSeriesDetails(tvSeries['results'][i]['id'].toString());
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
                                    'https://image.tmdb.org/t/p/w185/${tvSeries['results'][i]['poster_path']}',
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
                                      '${tvSeries['results'][i]['name']}',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        RatingBar(
                                          initialRating: (tvSeries['results'][i]['vote_average'])/2,
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
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('${tvSeries['results'][i]['vote_average']}',style: TextStyle(fontFamily: 'Ubuntu',fontSize: 16.0),)
                                      ],
                                    ),
                                    Container(
                                      height:20.0,
                                      margin:EdgeInsets.only(top:10.0,bottom:10.0),
                                      child: ListView(
                                        scrollDirection:Axis.horizontal,
                                        children: [
                                          for (var j = 0;j < tvSeries['results'][i]['genre_ids'].length;j++)
                                            Container(
                                              margin:EdgeInsets.only(right:10.0),
                                              child: Text(
                                                '${getMovieGenre(tvSeries['results'][i]['genre_ids'][j])}',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${tvSeries['results'][i]['first_air_date']}',
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
            }),
      ],
    );
  }
}


