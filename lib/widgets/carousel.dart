import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  Carousel(
      {this.future,
      this.apiCall,
      this.routeName,
      this.arguments,
      this.imageUrl,
      this.carouselImages});

  final future;
  final apiCall;
  final routeName;
  final arguments;
  final imageUrl;
  final carouselImages;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
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
                        onTap: () async {
                          await apiCall(i['id']);
                          Navigator.pushNamed(context, '/$routeName',
                              arguments: arguments);
                        },
                        child: Container(
                          height: 200.0,
                          width: 350.0,
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 30.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              '$imageUrl',
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
              height: 100.0,
              width: 100.0,
              child: Container(),
            ),
          );
        });
  }
}
