import 'dart:io';

import 'package:demo_omex_project/component/CustomPopup.dart';
import 'package:demo_omex_project/model/EmptyRes.dart';
import 'package:demo_omex_project/model/ResAppliedActors.dart';
import 'package:demo_omex_project/model/ResGetTagMarks.dart';
import 'package:demo_omex_project/pages/audition_page.dart';
import 'package:demo_omex_project/services/userPreferencesService.dart';
import 'package:demo_omex_project/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AppliedActors extends StatefulWidget {
  const AppliedActors({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _AppliedActorsState createState() => _AppliedActorsState();
}

class _AppliedActorsState extends State<AppliedActors> {
  var isLoading = false;
  final dio = new Dio();

  var isAppliedActors = true;

  List<String> selectedIds = [];

  List<ResAppliedActorsList> actors = [];

  List<ResGetTagMarksList> tagMarks;

  @override
  void initState() {
    _getTagMarks();
    _getAppliedActors();
    super.initState();
  }

  launchURL(String url) async {
    if (Platform.isAndroid) {
      await launch(url, forceWebView: false);
    } else {
      await launch(url, forceSafariVC: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applied Actors'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _body(),
            if (isLoading) _buildProgressIndicator(isLoading),
          ],
        ),
      ),
    );
  }

  Column _body() {
    return Column(
      children: [
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        isAppliedActors = true;
                      });
                      _getAppliedActors();
                    },
                    child: Row(
                      children: [
                        Radio<bool>(
                            value: true,
                            groupValue: isAppliedActors,
                            onChanged: (bool value) {
                              setState(() {
                                isAppliedActors = value;
                              });
                              _getAppliedActors();
                            }),
                        Text(
                          'Applied Actors',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isAppliedActors = false;
                      });
                      _getAppliedActors();
                    },
                    child: Row(
                      children: [
                        Radio<bool>(
                            value: false,
                            groupValue: isAppliedActors,
                            onChanged: (bool value) {
                              setState(() {
                                isAppliedActors = value;
                              });
                              _getAppliedActors();
                            }),
                        Text(
                          'Selected Actors',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )),
                OutlinedButton(
                    onPressed: () {
                      _selectAppliedActor();
                    },
                    child: Text('Save'))
              ],
            ),
          ),
        ),
        Container(
          child: Wrap(
            children: [
              OutlinedButton(
                  onPressed: () {
                    if (selectedIds.isEmpty) {
                      Fluttertoast.showToast(msg: 'Please Select Actor');
                      return;
                    }
                    CustomPopupField(context,
                        title: 'Add Budget',
                        message: '',
                        primaryBtnTxt: 'Save',
                        hint: 'Enter Budget',
                        isOnlyNumbers: true,
                        secondaryBtnTxt: 'Cancel', primaryAction: (text) {
                      _updateBudget(text);
                    });
                  },
                  child: Text('Add Budget')),
              SizedBox(width: 10),
              OutlinedButton(
                  onPressed: () {
                    if (selectedIds.isEmpty) {
                      Fluttertoast.showToast(msg: 'Please Select Actor');
                      return;
                    }
                    CustomPopupList(context,
                        title: 'Add TagMark',
                        message: '',
                        primaryBtnTxt: 'Add',
                        texts: tagMarks.map((e) => e.tagMarkName).toList(),
                        secondaryBtnTxt: 'Cancel', primaryAction: (list, text) {
                      if (list.length == 0) {
                        _addTagMarks([text]);
                      } else {
                        _addTagMarks(list);
                      }
                    });
                  },
                  child: Text('Add TagMark')),
              SizedBox(width: 10),
              OutlinedButton(
                  onPressed: () {
                    if (selectedIds.isEmpty) {
                      Fluttertoast.showToast(msg: 'Please Select Actor');
                      return;
                    }
                    CustomPopupList(context,
                        title: 'Remove TagMark',
                        message: '',
                        primaryBtnTxt: 'Remove',
                        texts: tagMarks.map((e) => e.tagMarkName).toList(),
                        secondaryBtnTxt: 'Cancel', primaryAction: (list, text) {
                      if (list.length == 0) {
                        _removeTagMarks([text]);
                      } else {
                        _removeTagMarks(list);
                      }
                    });
                  },
                  child: Text('Remove TagMark')),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: actors.length,
            itemBuilder: (context, index) {
              final data = actors[index];

              return Container(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.name ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Checkbox(
                                value: selectedIds.contains(data.actorsId),
                                onChanged: (isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      selectedIds.add(data.actorsId);
                                    } else {
                                      selectedIds.remove(data.actorsId);
                                    }
                                  });
                                }),
                            //Menu
                            Visibility(
                              visible: false,
                              child: Container(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton<String>(
                                  onSelected: (String result) {
                                    if (result == "Delete") {
                                      print('delete');
                                    } else if (result == "Edit") {
                                      print("Edit");
                                    } else if (result == "Copy") {
                                    } else if (result == "AppliedActors") {}
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: "Select",
                                      child: Text('Delete'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: "Edit",
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: "Copy",
                                      child: Text('Copy'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: "AppliedActors",
                                      child: Text('AppliedActors'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Actions: ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  launchURL(
                                      'https://wa.me/${Uri.encodeComponent(data.mobileNumber ?? '')}');
                                },
                                child: SizedBox(
                                    width: 44,
                                    child: Center(
                                        child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                                'asset/images/whatsapp-icon.png'))))),
                            InkWell(
                                onTap: () {
                                  launchURL(
                                      'tel:${Uri.encodeComponent(data.mobileNumber ?? '')}');
                                },
                                child: SizedBox(
                                    width: 44,
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.red,
                                    ))),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AuditionPage(
                                            actorId: data.actorsId,
                                            actorName: data.name,
                                          ),
                                      fullscreenDialog: true));
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Minimum Budget:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${data.minimumBudget ?? ''}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tags: ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Expanded(child: Text('${data.tagMark ?? ''}')),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Ratings(
                        //   onChange: (index) {
                        //     _updateStarRating(ratings: index,id: data.actorsId ?? 0);
                        //   },
                        //   givenRatings: data.starRating ?? 0,
                        // ),
                        InkWell(
                          onTap: () {
                            CustomPopupForStarRating(context,
                                title: 'Add Ratings', primaryAction: (stars) {
                              _updateStarRating(
                                  ratings: stars, id: data.actorsId ?? '');
                            },
                                primaryBtnTxt: 'Save',
                                starRating: data.starRating ?? 0,
                                secondaryBtnTxt: 'Cancel');
                          },
                          child: Row(
                            children: [
                              Icon(
                                  data.starRating >= 1
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.orangeAccent,
                                  size: 35),
                              Icon(
                                  data.starRating >= 2
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.orangeAccent,
                                  size: 35),
                              Icon(
                                  data.starRating >= 3
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.orangeAccent,
                                  size: 35),
                              Icon(
                                  data.starRating >= 4
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.orangeAccent,
                                  size: 35),
                              Icon(
                                  data.starRating >= 5
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.orangeAccent,
                                  size: 35),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _getAppliedActors() async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        selectedIds = [];
        isLoading = true;
      });
      var url = kBaseUrl +
          "GetAppliedRequirementActors"; //(isAppliedActors ? "GetAppliedRequirementActors" : "GetSelectedAppliedActors");
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print(widget.id);
      final response = await dio.post(url, data: {'ID': widget.id});
      print(response);
      //TODO:- Set Response to ResModel

      final actors = ResAppliedActors.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (actors.status) {
        case 1:
          //TODO:- Setup UI
          setState(() {
            if (isAppliedActors) {
              this.actors =
                  actors.data.where((element) => !element.isSelected).toList();
            } else {
              this.actors =
                  actors.data.where((element) => element.isSelected).toList();
            }
          });
          break;
        case 0:
          Fluttertoast.showToast(msg: actors.message);
          break;
      }
    }
  }

  void _selectAppliedActor() async {
    if (selectedIds.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Select Actor');
      return;
    }
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + ("SelectAppliedActor");
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print(selectedIds.join(','));

      print({
        'ID': widget.id,
        'ActorsID': selectedIds.join(','),
        "Mode": isAppliedActors ? "Applied" : "Selected"
      });

      final response = await dio.post(url, data: {
        'ID': widget.id,
        'ActorsID': selectedIds.join(','),
        "Mode": isAppliedActors ? "Applied" : "Selected"
      });
      print(response);
      //TODO:- Set Response to ResModel

      final res = EmptyRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (res.status) {
        case 1:
          //TODO:- Setup UI
          setState(() {
            selectedIds = [];
          });
          _getAppliedActors();
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }

  void _updateStarRating({int ratings, String id}) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + ("UpdateStarRating");
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print({'ActorsId': id, 'Rating': ratings});
      final response =
          await dio.post(url, data: {'ActorsId': id, 'Rating': ratings});
      print(response);
      //TODO:- Set Response to ResModel

      final res = EmptyRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (res.status) {
        case 1:
          //TODO:- Setup UI
          setState(() {
            selectedIds = [];
          });
          _getAppliedActors();
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }

  void _updateBudget(String amount) async {
    if (selectedIds.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Select Actor');
      return;
    }
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + ("UpdateBudget");
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print(selectedIds.join(','));
      final response = await dio.post(url,
          data: {'Budget': amount, 'ActorsID': selectedIds.join(',')});
      print(response);
      //TODO:- Set Response to ResModel

      final res = EmptyRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (res.status) {
        case 1:
          //TODO:- Setup UI
          setState(() {
            selectedIds = [];
          });
          _getAppliedActors();
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }

  void _getTagMarks() async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + ("GetTagMarks");
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print(selectedIds.join(','));
      final response = await dio.post(url, data: {});
      print(response);
      //TODO:- Set Response to ResModel

      final res = ResGetTagMarks.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (res.status) {
        case 1:
          //TODO:- Setup UI
          setState(() {
            tagMarks = res.data;
          });
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }

  void _addTagMarks(List<String> tagMarks) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + ("AddTagMarks");
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print({
        'TagMarkName': tagMarks.join(','),
        'ActorId': selectedIds.join(',')
      });
      final response = await dio.post(url, data: {
        'TagMarkName': tagMarks.join(','),
        'ActorId': selectedIds.join(',')
      });
      print(response);
      //TODO:- Set Response to ResModel

      final res = EmptyRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (res.status) {
        case 1:
          //TODO:- Setup UI
          _getAppliedActors();
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }

  void _removeTagMarks(List<String> tagMarks) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + ("RemoveTagMarks");
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print(selectedIds.join(','));
      final response = await dio.post(url, data: {
        'TagMarkName': tagMarks.join(','),
        'ActorId': selectedIds.join(',')
      });
      print(response);
      //TODO:- Set Response to ResModel

      final res = EmptyRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (res.status) {
        case 1:
          //TODO:- Setup UI
          _getAppliedActors();
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }
}

class Ratings extends StatefulWidget {
  const Ratings({Key key, this.givenRatings, this.onChange}) : super(key: key);

  final int givenRatings;

  final Function(int) onChange;

  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  int selectedRatings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      selectedRatings = widget.givenRatings;
    });
  }

  changeRatings(int index) {
    widget.onChange(index);
    setState(() {
      selectedRatings = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              changeRatings(1);
            },
            child: Icon(selectedRatings >= 1 ? Icons.star : Icons.star_border,
                color: Colors.orangeAccent, size: 35)),
        InkWell(
            onTap: () {
              changeRatings(2);
            },
            child: Icon(selectedRatings >= 2 ? Icons.star : Icons.star_border,
                color: Colors.orangeAccent, size: 35)),
        InkWell(
            onTap: () {
              changeRatings(3);
            },
            child: Icon(selectedRatings >= 3 ? Icons.star : Icons.star_border,
                color: Colors.orangeAccent, size: 35)),
        InkWell(
            onTap: () {
              changeRatings(4);
            },
            child: Icon(selectedRatings >= 4 ? Icons.star : Icons.star_border,
                color: Colors.orangeAccent, size: 35)),
        InkWell(
            onTap: () {
              changeRatings(5);
            },
            child: Icon(selectedRatings >= 5 ? Icons.star : Icons.star_border,
                color: Colors.orangeAccent, size: 35)),
      ],
    );
  }
}

Widget _buildProgressIndicator(bool isLoading) {
  return new Padding(
    padding: const EdgeInsets.all(8.0),
    child: new Center(
      child: new Visibility(
        visible: isLoading,
        child: new CircularProgressIndicator(),
      ),
    ),
  );
}
