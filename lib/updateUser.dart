import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUser extends StatefulWidget {
  final String id;
  final String name;
  final String mobile;

  const UpdateUser({Key key, this.id, this.name, this.mobile})
      : super(key: key);
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final textUsername = TextEditingController();
  final textmobile = TextEditingController();
  bool _valName = false;
  bool _valMobile = false;

  Future __updateDetails(String name, String mobile) async {
    var url = "http://192.168.1.8/api/update.php";

    final response = await http
        .post(url, body: {"id": widget.id, "name": name, "mobile": mobile});

    var res = response.body;

    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error" + res);
    }
  }

  Future __deleteDetails() async {
    var url = "http://192.168.1.6/api/delete.php";

    final response = await http.post(url, body: {"id": widget.id});

    var res = response.body;

    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error" + res);
    }
  }

  @override
  void dispose() {
    textUsername.dispose();
    textmobile.dispose();
    super.dispose();
  }

  void initState() {
    textUsername.text = widget.name;
    textmobile.text = widget.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update User'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "Full Name",
                      labelText: "Full Name",
                      errorText: _valName ? "Please Enter the Name" : null),
                  controller: textUsername,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Mobile Number",
                    labelText: "Mobile Number",
                    errorText:
                        _valMobile ? "Please Enter the Mobile Number" : null,
                  ),
                  keyboardType: TextInputType.number,
                  controller: textmobile,
                ),
                ButtonBar(
                  children: [
                    RaisedButton(
                        color: Colors.green,
                        child: Text("Update Details".toUpperCase()),
                        onPressed: () {
                          setState(() {
                            textUsername.text.isEmpty
                                ? _valName = true
                                : _valName = false;
                            textmobile.text.isEmpty
                                ? _valMobile = true
                                : _valMobile = false;
                            if (_valMobile == false && _valName == false) {
                              __updateDetails(
                                  textUsername.text, textmobile.text);
                            }
                          });
                        }),
                    RaisedButton(
                        color: Colors.red,
                        child: Text("Delete".toString().toUpperCase()),
                        onPressed: () {
                          __deleteDetails();
                        })
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
