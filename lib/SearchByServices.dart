import 'package:flutter/material.dart';

import 'HospListBuilder.dart';
import 'med_dbhelper.dart';
import 'med_data.dart';

class SearchByServices extends SearchDelegate<String> {
  List<MedData> _list;
  List _services = DatabaseHelper().getservices();
  SearchByServices(this._list);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.red,
      textTheme: TextTheme(
        title: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List _result = new List();
    _services.forEach((_) {
      if (_.toLowerCase().contains(query.toLowerCase())) _result.add(_);
    });
    print(_result.toString());
    return Serv2Hosp(_list, _result);
  }
}

class Serv2Hosp extends StatelessWidget {
  final List _serv;
  final List<MedData> _hosp;
  final ScrollController _cont = ScrollController();
  Serv2Hosp(this._hosp, this._serv);

  List<MedData> listHosp(String query) {
    List<MedData> _ = [];
    _hosp.forEach((h) {
      if (h.strservices.toString().contains(query)) _.add(h);
    });
    return _;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _serv.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(children: <Widget>[
          ListTile(
              title: Text(_serv[index].toString()),
              leading: Icon(Icons.subdirectory_arrow_right),
              onTap: () {
                List<MedData> _ = listHosp(_serv[index].toString());
                print(_);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Scaffold(
                        appBar:
                            AppBar(title: Text("${_serv[index].toString()}")),
                        body: HospListBuilder(_, _cont, false))));
              }),
          Divider()
        ]);
      },
    );
  }
}
