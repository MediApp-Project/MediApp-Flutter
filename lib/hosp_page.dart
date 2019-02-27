import 'med_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/scheduler.dart' show timeDilation;


class HospPage extends StatelessWidget {

  final MedData op;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HospPage(this.op);
  List<Widget> getConsultants() {
    List<Widget> _ = [];
    op.consultants.forEach((cons) {
      _.add(ListTile(
        title: Text(cons[0]),
        subtitle: Text(cons[1]),
        onLongPress: () {
          if (cons[0] != "na") copy(cons[0]);
        },
      ));
    });
    return _;
  }

  List<Widget> getPhone() {
    List<Widget> _ = [];
    op.phone.substring(6).split('/').forEach((no) {
      _.add(ListTile(
        leading: Icon(Icons.dialpad, color: Colors.red),
        title: Text(no),
        onLongPress: () {
          copy(no);
        },
        onTap: () async {
          if (await canLaunch("tel:$no")) launch("tel:$no");
        },
      ));
    });
    return _;
  }

  List<Widget> getSF() {
    List<Widget> _ = [];
    op.services.forEach((sf) {
      var glink = "https://www.google.co.in/search?&q=${sf.toString()}";
      _.add(ListTile(
          title: Text(sf),
          onLongPress: () {
            if (sf != "info na") copy(sf);
          },
          onTap: () async {
            if (await canLaunch(glink) && sf != "info na") launch(glink);
          }));
    });
    return _;
  }

  void copy(String txt) {
    Clipboard.setData(ClipboardData(text: txt));
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 500),
      content: Text("Text Copied to Clipboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    timeDilation=1.24;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(op.name),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Hero(
                tag: op.name,
                child: CachedNetworkImage(
                  height: 200,
                  fit: BoxFit.fill,
                  imageUrl: op.img,
                  placeholder: Icon(Icons.location_city, color: Colors.red,size: 200),
                )),
            Divider(color: Colors.black26),
            ListTile(
              isThreeLine: true,
              onLongPress: () {
                copy(op.addr);
              },
              onTap: () async {
                if (await canLaunch(op.map)) launch(op.map);
              },
              title: Text(op.addr),
              subtitle: Text("\nPincode:  " + op.pincode.toString()),
              trailing: Icon(Icons.location_on, color: Colors.red),
            ),
            Divider(color: Colors.black26, height: 0),
            ListTile(
              isThreeLine: true,
                onLongPress: () {
                  copy(op.website);
                },
                onTap: () async {
                  if (await canLaunch(op.website)) launch(op.website);
                },
                title: Text("Website"),
                subtitle: Text("\n"+op.website),
                trailing: Icon(Icons.language, color: Colors.red)),
            Divider(color: Colors.black26, height: 0),
            ExpansionTile(
              title: Text("Phone numbers"),
              children: getPhone(),
            ),
            Divider(color: Colors.black26, height: 0),
            ExpansionTile(
              title: Text("Services & Facilities"),
              children: getSF(),
            ),
            Divider(color: Colors.black26, height: 0),
            ExpansionTile(
              title: Text("Consultants"),
              children: getConsultants(),
            ),
            Divider(color: Colors.black26, height: 0)
          ],
        )));
  }
}
