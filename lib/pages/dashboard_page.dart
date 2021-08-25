import 'package:demo_omex_project/model/GetRequirementByTitleRes.dart';
import 'package:demo_omex_project/pages/view_item.dart';
import 'package:demo_omex_project/services/userPreferencesService.dart';
import 'package:demo_omex_project/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'add_item.dart';

class DashboardPage extends StatefulWidget {
  final int projectID;

  const DashboardPage({Key key, this.projectID}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  bool isLoading = false;
  List<Datum> list = [];
  final dio = new Dio();
  @override
  void initState() {
    this._getRequirementData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requirements"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            list.length != 0 ? _buildListItem() : Container(),
            if (isLoading) _buildProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditItem(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListItem() {
    return ListView.builder(
      itemCount: isLoading
          ? list.length + 1
          : list.length, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == list.length) {
          return _buildProgressIndicator();
        } else {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewItemScreen(),
                ),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Main Role Only",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          "It is a long established fact that a reader will be distracted b",
                          overflow: TextOverflow.ellipsis),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Categories : Lv4 -Lead characters,Lv1 - 1-2 day"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Age From : 18"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Age To : 30"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Minimum Budget : 5000"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Maximum Budget: 50000"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Gender : Male"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Languages : English, Hindi"),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _getRequirementData() async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "GetRequirement";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      final response = await dio.post(url);
      print(response);
      var mGetProjectTitleRes =
          GetRequirementByTitleRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (mGetProjectTitleRes.status) {
        case 1:
          setUi(mGetProjectTitleRes.data);
          break;
        case 0:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          break;
      }
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void setUi(List<Datum> data) {
    setState(() {
      isLoading = false;
      list = data;
    });
  }
}
