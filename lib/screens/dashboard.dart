import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.lightBlue
                        ),
                        child: Icon(
                          Icons.person,
                          size: 100.0,
                        ),
                      ),
                      SizedBox(
                          height:20.0
                      ),
                      Text('Test User',style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                ),
                Text('Version:1.0(beta)',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),),
                SizedBox(
                    height:30.0
                ),
                Text('Maintained by Vineet Kumar',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
