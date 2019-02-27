import 'med_dbhelper.dart';
import 'HomeScreen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashScreen()));
}

class SplashScreen extends StatelessWidget {
  Widget buildSplashScreen() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.red),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70.0,
                      child: Icon(
                        Icons.local_hospital,
                        color: Colors.red,
                        size: 80.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      "MediApp",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0,bottom: 10.0),
                  ),
                  Text(
                    "For the expected, unexpected and everything in between",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: Colors.white),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: DatabaseHelper().getdata(),
          builder: (BuildContext context, AsyncSnapshot medsnap) {
            if (medsnap.hasData)
              return HomeScreen(medsnap.data);
            else
              return buildSplashScreen();
          }),
    );
  }
}
