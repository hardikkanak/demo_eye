import 'package:demo_omex_project/model/AddProjectTitleRes.dart';
import 'package:demo_omex_project/model/GetProjectTitleRes.dart';
import 'package:demo_omex_project/pages/dashboard_page.dart';
import 'package:demo_omex_project/services/userPreferencesService.dart';
import 'package:demo_omex_project/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool isLoading = false;
  List<Datum> list = [];
  final dio = new Dio();
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    this._getMoreDataNew();
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
        title: const Text("Project"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            list.length != 0
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1.0),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _boxDesignNew(list[index]);
                    },
                  )
                : Container(),
            if (isLoading) _buildProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // CustomPopup(context,
          //     title: 'Project',
          //     message: 'Enter project name',
          //     primaryBtnTxt: 'OK', primaryAction: (data) {
          //   if (data.isEmpty) {
          //     Fluttertoast.showToast(msg: "Please enter project name");
          //   } else {
          //     _AddNewItem(data);
          //     print(data);
          //   }
          // }, secondaryBtnTxt: "Cancel");
          _displayTextInputDialog(context, -1, "");
        },
      ),
    );
  }

  Widget _boxDesignNew(Datum user_item) {
    String formattedDate =
        new DateFormat('yyyy-MM-dd').format(user_item.createdOn);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(projectID: user_item.id),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    user_item.requirementTitle,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                )),
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    if (result == "Delete") {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete"),
                              content: Text("Are you sure you want to delete?"),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No")),
                                FlatButton(
                                    onPressed: () {
                                      print(user_item);
                                      Navigator.of(context).pop();
                                      _DeleteItem(user_item.id.toString());
                                    },
                                    child: Text("Yes")),
                              ],
                            );
                          });
                    } else if (result == "Edit") {
                      print("Edit");
                      print(user_item.requirementTitle);

                      _displayTextInputDialog(
                          context, user_item.id, user_item.requirementTitle);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: "Delete",
                      child: Text('Delete'),
                    ),
                    const PopupMenuItem<String>(
                      value: "Edit",
                      child: Text('Edit'),
                    ),
                  ],
                )
              ],
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  formattedDate,
                  textAlign: TextAlign.right,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getMoreDataNew() async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "GetProjectTitle";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      final response = await dio.post(url);
      print(response);
      var mGetProjectTitleRes = GetProjectTitleRes.fromJson(response.data);

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

  void _AddNewItem(String projectName) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "AddProjectTitle";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      final response =
          await dio.post(url, data: {"RequirementTitle": projectName});
      print(response);
      var mGetProjectTitleRes = AddProjectTitleRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (mGetProjectTitleRes.status) {
        case 1:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          this._getMoreDataNew();
          break;
        case 0:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          break;
      }
    }
  }

  void _EditNewItem(String projectName, int ID) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "UpdateProjectTitle";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      final response = await dio
          .post(url, data: {"ID": ID, "RequirementTitle": projectName});
      print(response);
      var mGetProjectTitleRes = AddProjectTitleRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (mGetProjectTitleRes.status) {
        case 1:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          this._getMoreDataNew();
          break;
        case 0:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          break;
      }
    }
  }

  void _DeleteItem(String ID) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "DeleteProjectTitle";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      final response = await dio.post(url, data: {"ID": ID});
      print(response);
      var mGetProjectTitleRes = AddProjectTitleRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (mGetProjectTitleRes.status) {
        case 1:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          this._getMoreDataNew();
          break;
        case 0:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          break;
      }
    }
  }

  Widget _buildProgressIndicator() {
    return Center(
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
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

  Future<void> _displayTextInputDialog(
      BuildContext context, int ID, String projectName) async {
    if (projectName != "") {
      _textFieldController.text = projectName;
    } else {
      _textFieldController.text = "";
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Project'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(
                hintText: ID == -1 ? "Add Project" : "Edit Project"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                print(_textFieldController.text);
                if (_textFieldController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please enter project name");
                } else {
                  Navigator.pop(context);
                  if (ID == -1) {
                    _AddNewItem(_textFieldController.text);
                  } else {
                    _EditNewItem(_textFieldController.text, ID);
                  }

                  print(_textFieldController.text);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
