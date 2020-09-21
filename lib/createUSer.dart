import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateUSer extends StatefulWidget {
  @override
  _CreateUSerState createState() => _CreateUSerState();
}

class _CreateUSerState extends State<CreateUSer> {
  final textUsername = TextEditingController();
  final textmobile = TextEditingController();
  bool _valName = false;
  bool _valMobile = false;

  Future __saveDetails(String name, String mobile) async {
    var url = "http://192.168.1.8/api/create.php";

    final response =
        await http.post(url, body: {"name": name, "mobile": mobile});
    var res = response.body;

    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error" + res);
    }
  }

  void dispose() {
    textUsername.dispose();
    textmobile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD USER'),
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
                      child: Text("Save Details".toString().toUpperCase()),
                      onPressed: () {
                        setState(() {
                          textUsername.text.isEmpty
                              ? _valName = true
                              : _valName = false;
                          textmobile.text.isEmpty
                              ? _valMobile = true
                              : _valMobile = false;
                          if (_valMobile == false && _valName == false) {
                            __saveDetails(textUsername.text, textmobile.text);
                          }
                        });
                      }),
                  RaisedButton(
                      color: Colors.red,
                      child: Text("Clear".toString().toUpperCase()),
                      onPressed: () {
                        textUsername.clear();
                        textmobile.clear();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
