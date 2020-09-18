import 'package:flutter/material.dart';


class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  String searchInput;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search,size: 30.0,color: Colors.black),
        backgroundColor: Colors.white,
        title: TextFormField(
          textInputAction: TextInputAction.search,
          textAlign: TextAlign.start,
          onFieldSubmitted: (value){
            searchInput=value;
            print(searchInput);
            Navigator.pushNamed(context, '/searchResults',arguments: searchInput);
          },
          style: TextStyle(fontSize: 16.0,color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Search for Movies, Tv Series, Web Series and More',
            hintStyle: TextStyle(fontSize: 18.0,color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.0,
                color: Colors.white
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0,color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0,color: Colors.white),
            ),
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
