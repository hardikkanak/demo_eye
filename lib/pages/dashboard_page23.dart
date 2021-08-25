import 'dart:convert';

import 'package:demo_omex_project/pages/add_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final key = GlobalKey<AnimatedListState>();

  static int page = 0;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();

  Future<dynamic> getAllPassenger() async {
    final response = await http.get(Uri.parse(
        "https://api.instantwebtools.net/v1/passenger?page=0&size=50"));
    if (response.statusCode == 200) {
      var mainJson = json.decode(response.body);
      var datalist = mainJson['data'];
      return datalist;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data"),
      ),
      body: FutureBuilder(
          future: getAllPassenger(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error));
            } else if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/originals/83/2a/46/832a460b522c84fa9650c11face5927e.jpg')),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data[index]['name']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text('${snapshot.data[index]['_id']}')
                          ])
                    ],
                  );
                },
              );
            } else {
              return Container(child: Text("No data found"));
            }
          }),
      floatingActionButton: FloatingActionButton(
          // onPressed: () =>
          //     {animatedList.insert(0, "Hello"), key.currentState.insertItem(0)
          //     },
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditItem(),
              ),
            );
          },
          child: Icon(Icons.add)),
    );
  }
}
