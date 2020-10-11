import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/dashboard.dart';
import 'package:movies_app/screens/movies.dart';
import 'package:movies_app/screens/tv_series.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [Movies(), WebSeries(), Dashboard()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 90.0),
        child: SafeArea(
          child: Container(
            height: 100.0,
            padding: EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0,bottom: 10.0),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset('images/film.png',
                    height: 40.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Movies Cite',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon:Icon(Icons.search,
                  size: 30.0,
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, '/search');
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom:8.0,left:8.0,right: 8.0),
        child: BottomNavigationBar(
          elevation: 5.0,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          backgroundColor:
              Color(0xFFF8F8F8), // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.movie),
              title: new Text('Movies'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              title: new Text('Tv Series'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Dashboard'))
          ],
        ),
      ),
    );
  }
}
