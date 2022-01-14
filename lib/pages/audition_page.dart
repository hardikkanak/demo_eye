import 'dart:convert';

import 'package:demo_omex_project/component/CustomPopup.dart';
import 'package:demo_omex_project/model/EmptyRes.dart';
import 'package:demo_omex_project/model/ResGetAuditionLink.dart';
import 'package:demo_omex_project/services/userPreferencesService.dart';
import 'package:demo_omex_project/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AuditionPage extends StatefulWidget {
  const AuditionPage({Key key, this.actorName, this.actorId}) : super(key: key);

  final String actorName;
  final String actorId;

  @override
  _AuditionPageState createState() => _AuditionPageState();
}

class _AuditionPageState extends State<AuditionPage> {
  var isLoading = false;
  final dio = new Dio();

  List<ResGetAuditionLinkList> linkList;

  String profileInformation = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLinks();
    _getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details (${widget.actorName})'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _body(),
            if (isLoading) _buildProgressIndicator(isLoading),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          CustomPopupForActorLink(context, title: 'Add', primaryBtnTxt: 'Save',primaryAction: (title,url){
            _addLinks(title: title,link: url);
          },secondaryBtnTxt: 'Cancel');
        },
      ),
    );
  }

  Widget _body() {
    if (linkList == null) {
      return Container();
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 44),
      itemCount: linkList.length + 1,
      itemBuilder: (context, index) {

        if ((linkList.length) == index){
          return Padding(padding: EdgeInsets.symmetric(vertical: 2.5,horizontal: 8),child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Work History:',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 5),
                      Text('$profileInformation'),
                    ],
                  )),
                  SizedBox(width: 10),
                  InkWell(
                      onTap: () {
                        CustomPopupField(context, title: 'Work History', message: '', primaryBtnTxt: 'Save',secondaryBtnTxt: 'Cancel',hint: 'Add Work History',primaryAction: (text){
                          _editProfile(text: text);
                        },text: profileInformation,isMultiline: true);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),);
        }

        final data = linkList[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 8),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(data.urltitle ?? '')),
                  Column(
                    children: [
                      InkWell(
                          onTap: () {
                            if (data.auditionsLink.contains('http')) {
                              _launchURL(data.auditionsLink);
                            } else {
                              _launchURL('http://' + data.auditionsLink);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Open',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: data.auditionsLink));
                            Fluttertoast.showToast(msg: 'Link Copied!');
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Copy!',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(width: 10),
                  InkWell(
                      onTap: () {
                        CustomPopupForActorLink(context, title: 'Add', primaryBtnTxt: 'Save',primaryAction: (title,url){
                          _updateLinks(title: title,link: url,linkId: data.id);
                        },secondaryBtnTxt: 'Cancel',linkValue: data.auditionsLink,titleValue: data.urltitle);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _launchURL(String url) async => await canLaunch(url)
      ? await launch(url)
      : Fluttertoast.showToast(msg: 'Could not launch $url');

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

  void _getLinks() async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "getAuditionLink";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print({'ActorsID': widget.actorId});
      final response = await dio.post(url, data: {'ActorsID': widget.actorId});
      print(response);
      //TODO:- Set Response to ResModel

      final res = ResGetAuditionLink.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (res.status) {
        case 1:
          //TODO:- Setup UI
          setState(() {
            linkList = res.data;
          });
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }

  void _getProfileDetails() async {

    if (!isLoading) {
      try {
        var accesstoken = await UserPreferencesService().getAccesstoken();
        setState(() {
                isLoading = true;
              });
        var url = kBaseUrl + "getProfileDetails";
        dio.options.headers["authorization"] = "barear " + accesstoken;
        print(url);
        print("barear " + accesstoken);
        final response = await dio.post(url, data: {
                'ID': widget.actorId,
              });
        print(response);

        setState(() {
                isLoading = false;
              });

        if (response.data['Status'] == 1){
                List<dynamic> data = response.data['data'];
                Map<String,dynamic> firstObj = data[0];

                setState(() {
                  profileInformation = firstObj['ProfileInformation'];
                  print(profileInformation);
                });

              }
      } catch (e) {
        print(e);
      }

    }

  }

  void _addLinks({String title, String link}) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "AddAuditionLink";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      print('res + ${{
        'ActorsID': widget.actorId,
        'AuditionsLink': link,
        'urltitle': title,
      }}');

      final response = await dio.post(url, data: {
        'ActorsID': widget.actorId,
        'AuditionsLink': link,
        'urltitle': title,
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
          _getLinks();
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }

  void _updateLinks({String title, String link,int linkId}) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "UpdateAuditionLink";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);
      final response = await dio.post(url, data: {
        'ActorsID': widget.actorId,
        'AuditionsLink': link,
        'urltitle': title,
        'ID': linkId
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
          _getLinks();
          break;
        case 0:
          Fluttertoast.showToast(msg: res.message);
          break;
      }
    }
  }

  void _editProfile({String text}) async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl + "UpdateProfileDetails";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);

      final response = await dio.post(url, data: {
        'ID': widget.actorId,
        'ProfileInformation': text
      });
      print(response);
      //TODO:- Set Response to ResModel

      setState(() {
        isLoading = false;
      });

      if (response.data['Status'] == 1){
        _getProfileDetails();
      }
    }
  }

}
