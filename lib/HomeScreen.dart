import 'HospListBuilder.dart';
import 'med_data.dart';
import 'SideDrawer.dart';
import 'SearchList.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<MedData> items;
  HomeScreen(this.items);
  @override
  _HomeScreenState createState() => _HomeScreenState(this.items);
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _cont = ScrollController();
  List<MedData> items;
  _HomeScreenState(this.items);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, title: Text("MediApp"), actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: SearchList(items, _cont));
              })
        ]),
        drawer: SideDrawer(items),
        body: HospListBuilder(items, _cont, false));
  }
}
