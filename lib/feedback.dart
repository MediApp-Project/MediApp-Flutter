import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  String email = 'project.mediapp@gmail.com';
  bool anonymous = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final subject = TextEditingController();
  final body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Feedback")),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 20, 3, 0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please type subject';
                    }
                  },
                  controller: subject,
                  decoration: InputDecoration(hintText: 'Subject'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: 10,
                  maxLengthEnforced: false,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Description cannot be empty';
                    }
                  },
                  controller: body,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                CheckboxListTile(
                  value: anonymous,
                  title: Text('Send anonymously'),
                  subtitle: Text('Note: We cant email you if you enable it'),
                  onChanged: (bool ip) {
                    setState(() {
                      anonymous = ip;
                    });
                  },
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.red,
                  highlightColor: Colors.blueAccent,
                  child: Text('Submit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      if (anonymous) {
                        launch(
                            'https://docs.google.com/forms/u/1/d/e/1FAIpQLSdeNT0yOw4Kq7ByqSPBcpNdhfvJDf3QI6gPLkRu-vO0e1t7Ig/formResponse?usp=pp_url&entry.1523815961=${subject.text}&entry.152028202=${body.text}');
                      } else {
                        launch(
                            'mailto:$email?subject=${subject.text}&body=${body.text}');
                        Navigator.pop(context);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
