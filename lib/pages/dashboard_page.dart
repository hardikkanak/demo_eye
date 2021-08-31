import 'package:demo_omex_project/model/GetLanguages.dart';
import 'package:demo_omex_project/model/GetRequirementByTitleRes.dart';
import 'package:demo_omex_project/model/NormalRes.dart';
import 'package:demo_omex_project/pages/add_requirement_page.dart';
import 'package:demo_omex_project/pages/view_item.dart';
import 'package:demo_omex_project/services/userPreferencesService.dart';
import 'package:demo_omex_project/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DashboardPage extends StatefulWidget {
  final int projectID;

  final bool isEditing;

  const DashboardPage({Key key, this.projectID, this.isEditing}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  bool isLoading = false;
  List<Datum> list = [];
  List<GetLanguageList> languages = [];

  final dio = new Dio();
  @override
  void initState() {
    _getLanguages();
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
              builder: (context) => AddRequirementPage(
                success: (){
                  _getRequirementData();
                },
                titleID: widget.projectID,
                languages: languages,
                isEditing: false,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListItem() {
    return ListView.builder(
      itemCount: list.length, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        final data = list[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewItemScreen(languages: languages,data: data,),
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

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            data.characterTitle ?? '',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        //Menu
                        Container(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<String>(
                            onSelected: (String result) {
                              if (result == "Delete") {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Delete"),
                                        content: Text("Are you sure you want to delete?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () {
                                                _deleteRequirement(data.id ?? 0);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Yes")),
                                        ],
                                      );
                                    });
                              } else if (result == "Edit") {
                                print("Edit");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddRequirementPage(
                                      success: (){
                                        _getRequirementData();
                                      },
                                      titleID: widget.projectID,
                                      languages: languages,
                                      isEditing: true,
                                      data: data,
                                    ),
                                  ),
                                );

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
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data.categories ?? '',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 10.0,color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Short Desc : ' +
                        data.shortDescription ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Long Desc : ' + data.longDescription ?? '',maxLines: 3,overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Age From : ${data.ageFrom ?? 0}",maxLines: 1,overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Age To : ${data.ageTo ?? 0}",maxLines: 1,overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Minimum Budget : ${data.minimumBudget ?? 0}",maxLines: 1,overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Maximum Budget: ${data.maximumBudget ?? 0}",maxLines: 1,overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Gender For: ${getGenderText(data.gender)}",maxLines: 1,overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Languages : ${getLanguagesFrom(data.languages)}",maxLines: 2,overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  void _getLanguages() async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "GetLanguages";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      final response = await dio.post(url);
      print(response);
      var mGetProjectTitleRes =
      GetLanguages.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (mGetProjectTitleRes.status) {
        case 1:
          print('languages Obtained');

          setState(() {
            languages = mGetProjectTitleRes.data;
          });

          this._getRequirementData();
          break;
        case 0:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          break;
      }
    }
  }

  String getGenderText(Gender gender){
    switch(gender){
      case Gender.MALE_FEMALE:
        return 'Male & Female';
      case Gender.FEMALE:
        return 'Female';
      case Gender.MALE:
        return 'Male';
    }
    return '';
  }

  void _getRequirementData() async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "GetRequirementByTitle";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      final response = await dio.post(url,data: {
        'ID': widget.projectID ?? 0
      });
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

  void _deleteRequirement(int selectedID) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "DeleteRequirement";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      final response = await dio.post(url,data: {
        'ID': selectedID
      });
      print(response);
      var mGetProjectTitleRes =
      NormalRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (mGetProjectTitleRes.status) {
        case 1:
          _getRequirementData();
          break;
        case 0:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          break;
      }
    }
  }


  String getLanguagesFrom(String languages){

    final langCode = languages.split(',').toList();

    String languageComma = '';

    final selectedLangs = this.languages.where((element) {
      return langCode.contains('${element.id}');
    });

    languageComma = selectedLangs.map((e) {
      return e.languageName;
    }).join(',') ;


    return languageComma;

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
