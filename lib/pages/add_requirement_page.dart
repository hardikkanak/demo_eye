import 'package:demo_omex_project/model/GetLanguages.dart';
import 'package:demo_omex_project/model/GetRequirementByTitleRes.dart';
import 'package:demo_omex_project/model/NormalRes.dart';
import 'package:demo_omex_project/services/userPreferencesService.dart';
import 'package:demo_omex_project/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRequirementPage extends StatefulWidget {
  const AddRequirementPage(
      {Key key,
      this.data,
      this.languages,
      this.selectedLng,
      this.titleID,
      this.requirementID,
      this.isEditing,
      this.success})
      : super(key: key);

  final int titleID;
  final int requirementID;
  final String selectedLng;
  final Datum data;
  final List<GetLanguageList> languages;
  final bool isEditing;

  final Function success;

  @override
  _AddRequirementPageState createState() => _AddRequirementPageState();
}

class _AddRequirementPageState extends State<AddRequirementPage> {
  List<GetLanguageList> selectedLng = [];

  List<String> allCategories = [
    'Lv1 - 1-2 day ',
    'Lv2 -Cameos/strong characters',
    'Lv3 -Parallel lead/main cast',
    'Lv4 -Lead characters'
  ];

  List<String> selectedCategories = [];

  Gender gender = Gender.MALE;
  bool isRequired = true;
  TextEditingController minBudget;
  TextEditingController maxBudget;
  TextEditingController ageFrom;
  TextEditingController ageTo;

  TextEditingController categoriesTitle;
  TextEditingController categories;
  TextEditingController shortDesc;
  TextEditingController longDesc;

  bool isLoading = false;

  final dio = new Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    minBudget = TextEditingController();
    maxBudget = TextEditingController();
    ageFrom = TextEditingController();
    ageTo = TextEditingController();

    categoriesTitle = TextEditingController();
    categories = TextEditingController();
    shortDesc = TextEditingController();
    longDesc = TextEditingController();

    if ( widget.data != null && widget.data.categories != null){
      selectedCategories = widget.data.categories.split(',');
    }

    setState(() {
      if (widget.isEditing) {
        gender = widget.data.gender ?? Gender.MALE;

        minBudget.text = widget.data.minimumBudget.toString();
        maxBudget.text = widget.data.maximumBudget.toString();
        ageTo.text = widget.data.ageTo.toString();
        ageFrom.text = widget.data.ageFrom.toString();
        categoriesTitle.text = widget.data.characterTitle.toString();
        categories.text = widget.data.categories.toString();
        shortDesc.text = widget.data.shortDescription ?? '';
        longDesc.text = widget.data.longDescription ?? '';

        selectedLng = getSelectedLanguagesFrom(widget.data.languages ?? '');

        isRequired = widget.data.isOpen ?? true;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    minBudget.dispose();
    maxBudget.dispose();
    ageFrom.dispose();
    ageTo.dispose();

    categoriesTitle.dispose();
    categories.dispose();
    shortDesc.dispose();
    longDesc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requirement Details'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    final _size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: categoriesTitle,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Character Title',
                  hintText: 'Enter Character Title'),
            ),
            SizedBox(height: 10),
            // TextField(
            //   controller: categories,
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'Categories',
            //       hintText: 'Enter Categories'),
            // ),

            Text('Select Categories:',textAlign: TextAlign.start,),
            SizedBox(height: 5),
            categorySelection(),

            SizedBox(height: 10),
            titleTextField(
                size: _size, title: 'Minimum Budget:', controller: minBudget),
            SizedBox(height: 10),
            titleTextField(
                size: _size, title: 'Maximum Budget:', controller: maxBudget),
            SizedBox(height: 10),
            titleTextField(
                size: _size, title: 'Age From:', controller: ageFrom),
            SizedBox(height: 10),
            titleTextField(size: _size, title: 'Age To:', controller: ageTo),
            SizedBox(height: 20),
            Container(
                width: double.infinity,
                child: Text(
                  'Select Gender:',
                  textAlign: TextAlign.start,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _genderRadio(genderType: Gender.MALE, text: 'Male'),
                _genderRadio(genderType: Gender.FEMALE, text: 'Female'),
                _genderRadio(
                    genderType: Gender.MALE_FEMALE, text: 'Male & Female'),
              ],
            ),
            SizedBox(height: 10),
            Container(
                width: double.infinity,
                child: Text(
                  'Select Language:',
                  textAlign: TextAlign.start,
                )),
            SizedBox(height: 5),
            Container(
                height: 30,
                child: ListView.builder(
                  itemCount: widget.languages.length,
                  itemBuilder: (context, index) {
                    final allLanguages = widget.languages[index];

                    var isSelected = selectedLng
                        .where((element) => allLanguages.id == element.id)
                        .isNotEmpty;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedLng.remove(allLanguages);
                          } else {
                            selectedLng.add(allLanguages);
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 30,
                        decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.red.withOpacity(0.5)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all()),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: Text(allLanguages.languageName ?? ''),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(height: 20),
            TextField(
              controller: shortDesc,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Short Description',
                hintText: 'Enter Short Description',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: longDesc,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Long Description',
                hintText: 'Enter Long Description',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Open Requirement:'),
                Switch(
                    value: isRequired,
                    onChanged: (value) {
                      setState(() {
                        isRequired = value;
                      });
                    })
              ],
            ),
            SizedBox(height: 10),
            OutlinedButton(
                onPressed: () {
                  if (isLoading) {
                    return;
                  }

                  _addRequirement();
                },
                child: Container(
                    width: double.infinity,
                    height: 44.0,
                    child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.red,
                              )
                            : Text(widget.isEditing ? 'Update' : 'Save'))))
          ],
        ),
      ),
    );
  }

  Column categorySelection() {
    return Column(
      children: [for (String category in allCategories) CheckboxListTile(title: Text(category),value: selectedCategories.contains(category), onChanged: (isSelected){
        print(selectedCategories);
        print(allCategories);
        print(isSelected);
        setState(() {
          if(isSelected){
            selectedCategories.add(category);

          }else{
            selectedCategories.remove(category);
          }
        });
      })],
    );
  }

  Row titleTextField(
      {Size size, String title, TextEditingController controller}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Container(
          width: size.width / 2,
          // height: 44,
          child: Center(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: controller,
              decoration:
                  InputDecoration(border: OutlineInputBorder(), hintText: ''),
            ),
          ),
        )
      ],
    );
  }

  Row _genderRadio({String text, Gender genderType}) {
    return Row(
      children: [
        Radio<Gender>(
          value: genderType,
          groupValue: gender,
          onChanged: (Gender value) {
            // onChanged(value);
            setState(() {
              gender = value;
            });
          },
        ),
        Text(text)
      ],
    );
  }

  List<GetLanguageList> getSelectedLanguagesFrom(String languages) {
    final langCode = languages.split(',').toList();

    final selectedLangs = widget.languages.where((element) {
      return langCode.contains('${element.id}');
    });

    return selectedLangs.toList();
  }

  void _addRequirement() async {
    if (!isLoading) {
      var accesstoken = await UserPreferencesService().getAccesstoken();
      setState(() {
        isLoading = true;
      });
      var url = kBaseUrl +
          "${widget.isEditing ? 'UpdateRequirement' : 'AddRequirement'}";
      dio.options.headers["authorization"] = "barear " + accesstoken;
      print(url);
      print("barear " + accesstoken);

      final langs = selectedLng.map((e) => e.id).join(',');

      var data = {};

      if (widget.isEditing) {
        data = {
          "ID": widget.data.id ?? 0,
          "Gender": genderValues.reverse[gender],
          "MinimumBudget": int.parse(minBudget.text) ?? 0,
          "MaximumBudget": int.parse(maxBudget.text) ?? 0,
          "AgeFrom": int.parse(ageFrom.text) ?? 0,
          "AgeTo": int.parse(ageTo.text) ?? 0,
          "Languages": langs,
          "ShortDescription": shortDesc.text,
          "LongDescription": longDesc.text,
          "IsOpen": isRequired,
          "RequirementTitleID": widget.titleID,
          "Categories": selectedCategories.join(','),
          "CharacterTitle": categoriesTitle.text,
        };
      } else {
        data = {
          "Gender": genderValues.reverse[gender],
          "MinimumBudget": int.parse(minBudget.text) ?? 0,
          "MaximumBudget": int.parse(maxBudget.text) ?? 0,
          "AgeFrom": int.parse(ageFrom.text) ?? 0,
          "AgeTo": int.parse(ageTo.text) ?? 0,
          "Languages": langs,
          "ShortDescription": shortDesc.text,
          "LongDescription": longDesc.text,
          "IsOpen": isRequired,
          "RequirementTitleID": widget.titleID,
          "Categories": selectedCategories.join(','),
          "CharacterTitle": categoriesTitle.text,
        };
      }
      final response = await dio.post(url, data: data);
      print(response);
      var mGetProjectTitleRes = NormalRes.fromJson(response.data);

      setState(() {
        isLoading = false;
      });

      switch (mGetProjectTitleRes.status) {
        case 1:
          widget.success();
          Navigator.of(context).pop(true);
          break;
        case 0:
          Fluttertoast.showToast(msg: mGetProjectTitleRes.message);
          break;
      }
    }
  }
}
