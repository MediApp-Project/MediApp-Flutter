import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'hosp_page.dart';
import 'med_data.dart';


class HospListBuilder extends StatelessWidget {
  final List<MedData> medsnap;
  final ScrollController _cont;
  final bool _search;
  final double _itemextent = 88;
  HospListBuilder(this.medsnap, this._cont, this._search);

  Widget buildList() {
    return ListView.builder(
      controller: _cont,
      itemCount: medsnap.length,
      itemExtent: _itemextent,
      itemBuilder: (BuildContext context, int index) {
        return Column(children: [
          ListTile(
            title: Text(medsnap[index].name),
            subtitle: Text(medsnap[index].phone.split('/')[0]),
            leading: ClipOval(
                child: Hero(
              tag: medsnap[index].name,
              child: CachedNetworkImage(
                width: 45,
                height: 45,
                fit: BoxFit.cover,
                imageUrl: medsnap[index].img,
                placeholder:
                    Icon(Icons.location_city, color: Colors.red, size: 45)
              ),
            )),
            onTap: () {
              _search
		?Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HospPage(medsnap[index])))
		:Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HospPage(medsnap[index])));
            },
          ),
          Divider()
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation=1.5;
    return Container(
        margin: EdgeInsets.only(top: 8),
        child: _search == true
            ? buildList()
            : DraggableScrollbar.arrows(
                backgroundColor: Colors.red,
                labelTextBuilder: (offset) => Text(
                      medsnap[offset ~/ _itemextent].name[0],
                      style: TextStyle(color: Colors.white),
                    ),
                controller: _cont,
                child: buildList()));
  }
}
