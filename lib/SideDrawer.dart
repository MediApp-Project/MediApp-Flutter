import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'feedback.dart';
import 'SearchByServices.dart';

class SideDrawer extends StatelessWidget {
  final List _;
  SideDrawer(this._);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(height: 35),
        DrawerHeader(
          child: Text(''),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Divider(color: Colors.black26, height: 0),
        ListTile(
          title: Text('Search by Services'),
          onTap: () {
            showSearch(
                    context: context, delegate: SearchByServices(_));
          },
        ),
        Divider(color: Colors.black26, height: 0),
        ListTile(
          title: Text('Hospitals near me'),
          onTap: () {
            launch('https://www.google.com/maps/search/hospitals+near+me/');
          },
        ),
        Divider(color: Colors.black26, height: 0),
        ListTile(
          title: Text('Emergency Call'),
          onTap: () {
            launch('tel:112');
          },
        ),
        Divider(color: Colors.black26, height: 0),
        ListTile(
          title: Text('Feedback / Report wrong info'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FeedbackForm()));
          },
        ),
        Divider(color: Colors.black26, height: 0)
      ],
    ));
  }
}
