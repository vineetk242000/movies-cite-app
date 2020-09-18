import 'package:flutter/material.dart';



Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
height: 150.0,
width: 120.0,
margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
image: DecorationImage(
image: AssetImage('images/image3.jfif'),
fit: BoxFit.cover),
boxShadow: [
BoxShadow(
blurRadius: 4.0,
color: Color(0x66808080),
spreadRadius: 2.0,
offset: Offset(3.0, 3.0)),
]),
),
Padding(
padding: const EdgeInsets.only(
top: 15.0, bottom: 20.0, left: 25.0, right: 8.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Doctor Strange',
style: TextStyle(
fontSize: 20.0,
fontWeight: FontWeight.w500,
),
),
SizedBox(height: 10.0),
RatingBar(
initialRating: 3.2,
itemSize: 25.0,
minRating: 1,
direction: Axis.horizontal,
allowHalfRating: true,
itemCount: 5,
itemPadding:
EdgeInsets.symmetric(horizontal: 1.0),
itemBuilder: (context, _) => Icon(
Icons.star,
color: Colors.yellow[800],
size: 1.0,
),
onRatingUpdate: (rating) {
print(rating);
},
),
SizedBox(height: 10.0),
Text(
'Sci-fi',
style: TextStyle(
fontSize: 16.0,
color: Colors.grey,
),
),
SizedBox(height: 10.0),
Text(
'1 hr 33 min',
style: TextStyle(
fontSize: 16.0,
color: Colors.grey,
),
)
],
),
),
],
),
Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
height: 150.0,
width: 120.0,
margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
image: DecorationImage(
image: AssetImage('images/image4.jpg'),
fit: BoxFit.cover),
boxShadow: [
BoxShadow(
blurRadius: 4.0,
color: Color(0x66808080),
spreadRadius: 2.0,
offset: Offset(3.0, 3.0)),
]),
),
Padding(
padding: const EdgeInsets.only(
top: 15.0, bottom: 20.0, left: 25.0, right: 8.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Black Panther',
style: TextStyle(
fontSize: 20.0,
fontWeight: FontWeight.w500,
),
),
SizedBox(height: 10.0),
RatingBar(
initialRating: 3.2,
itemSize: 25.0,
minRating: 1,
direction: Axis.horizontal,
allowHalfRating: true,
itemCount: 5,
itemPadding:
EdgeInsets.symmetric(horizontal: 1.0),
itemBuilder: (context, _) => Icon(
Icons.star,
color: Colors.yellow[800],
size: 1.0,
),
onRatingUpdate: (rating) {
print(rating);
},
),
SizedBox(height: 10.0),
Text(
'Sci-fi , Action',
style: TextStyle(
fontSize: 16.0,
color: Colors.grey,
),
),
SizedBox(height: 10.0),
Text(
'1 hr 52 min',
style: TextStyle(
fontSize: 16.0,
color: Colors.grey,
),
)
],
),
),
],
),