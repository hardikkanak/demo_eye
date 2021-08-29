import 'package:demo_omex_project/model/GetLanguages.dart';
import 'package:demo_omex_project/model/GetRequirementByTitleRes.dart';
import 'package:flutter/material.dart';

class ViewItemScreen extends StatefulWidget {

  final Datum data;
  final List<GetLanguageList> languages;

  const ViewItemScreen({Key key,@required this.languages, @required this.data}) : super(key: key);

  @override
  _ViewItemScreenState createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {

  get data => widget.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requirements Details"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    data.characterTitle ?? '',
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    data.categories ?? '',
                    style: TextStyle(
                        fontSize: 15.0,color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Short Desc : ' +
                      data.shortDescription ?? ''),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Long Desc : ' + data.longDescription ?? ''),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Age To : ${data.ageTo ?? 0}"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Minimum Budget : ${data.minimumBudget ?? 0}"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Maximum Budget: ${data.maximumBudget ?? 0}"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Gender : ${data.gender == Gender.MALE ? 'Male' : 'Female'}"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Languages : ${getLanguagesFrom(data.languages)}"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getLanguagesFrom(String languages){

    final langCode = languages.split(',').toList();

    String languageComma = '';

    final selectedLangs = widget.languages.where((element) {
      return langCode.contains('${element.id}');
    });

    languageComma = selectedLangs.map((e) {
      return e.languageName;
    }).join(',') ;


    return languageComma;

  }

}
