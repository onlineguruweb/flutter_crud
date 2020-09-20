import 'package:flutter/material.dart';
import 'package:flutter_crud/createUSer.dart';
import 'package:flutter_crud/updateUser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    routes: <String, WidgetBuilder>{
      '/createuser': (BuildContext context) => CreateUSer()
    },
  ));
}

Future<List> getData() async {
  var url = "http://192.168.1.6/api/";

  final response = await http.get(url);
  var datareceived = json.decode(response.body);
  return datareceived;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CRUD '),
      ),
      body: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error in snapshot loading" + snapshot.hasError.toString());
            }
            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data,
                  )
                : Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {Navigator.pushNamed(context, '/createuser')}),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  const ItemList({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateUser(
                          id: list[i]['id'],
                          name: list[i]['name'],
                          mobile: list[i]['mobile'])));
            },
            leading: CircleAvatar(
              child: Text(
                  list[i]['name'].toString().substring(0, 1).toUpperCase()),
            ),
            title: Text(list[i]['name'].toString()),
            subtitle: Text(list[i]['mobile']),
          ),
        );
      },
    );
  }
}
