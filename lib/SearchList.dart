import 'package:flutter/material.dart';

import 'package:MediApp/HospListBuilder.dart';
import 'med_data.dart';

class SearchList extends SearchDelegate<String> {
  List<MedData> _list;
  ScrollController _cont;
  SearchList(this._list, this._cont);

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
    List<MedData> _result = new List();
    _list.forEach((_) {
      if (_.name.toLowerCase().contains(query.toLowerCase())) _result.add(_);
    });
    return HospListBuilder(_result, _cont, true);
  }
}
