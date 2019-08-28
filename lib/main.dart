import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: myHome(),
    ));

class myHome extends StatefulWidget {
  @override
  _myHomeState createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  Map data;
  List userData;

  Future getData() async {
    http.Response response =
        await http.get("https://reqres.in/api/users?=page=2");
    // debugPrint(response.body);
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    // debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Friends"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData[index]["avatar"]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${userData[index]["first_name"]} ${userData[index]["last_name"]}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
