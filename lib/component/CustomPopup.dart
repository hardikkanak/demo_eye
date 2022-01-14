import 'package:demo_omex_project/utils/ColorUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPopup {
  final String title;
  final String message;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final Function(String) primaryAction;
  final Function secondaryAction;
  final TextEditingController _editingController = TextEditingController();

  CustomPopup(BuildContext context,
      {@required this.title,
        @required this.message,
        @required this.primaryBtnTxt,
        this.secondaryBtnTxt,
        this.primaryAction,
        this.secondaryAction}) {
    final size = MediaQuery
        .of(context)
        .size;

    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.3),
            body: Center(
              child: Container(
                constraints: BoxConstraints(
                    minWidth: 100,
                    maxWidth: size.width * 0.9,
                    minHeight: 100,
                    maxHeight: size.height * 0.9),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon(Icons.close,color: Colors.transparent,),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // IconButton(icon: Icon(Icons.close), onPressed: (){
                          //   Navigator.of(context).pop();
                          // })
                        ],
                      ),
                    ),
                    // SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextField(
                      controller: _editingController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          if (secondaryBtnTxt != null)
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorUtil.primoryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    if (secondaryAction != null) {
                                      secondaryAction();
                                    }
                                  },
                                  child: Text(
                                    secondaryBtnTxt,
                                    style: TextStyle(
                                        color: ColorUtil.primoryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          if (secondaryBtnTxt != null)
                            SizedBox(
                              width: 10,
                            ),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: ColorUtil.primoryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if (primaryAction != null) {
                                    primaryAction(_editingController.text);
                                  }
                                },
                                child: Text(
                                  primaryBtnTxt,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class CustomPopupField {
  final String title;
  final String message;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final String hint;
  final Function(String) primaryAction;
  final Function secondaryAction;
  final bool isOnlyNumbers;
  final String text;
  final bool isMultiline;
  TextEditingController editingController = TextEditingController();


  CustomPopupField(BuildContext context,
      {@required this.title,
        @required this.message,
        @required this.primaryBtnTxt,
        this.secondaryBtnTxt,
        this.primaryAction,
        this.hint,
        this.isOnlyNumbers,
        this.secondaryAction,
        this.text,
        this.isMultiline
      }) {
    final size = MediaQuery
        .of(context)
        .size;

    editingController = TextEditingController(text: text);

    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.3),
            body: Center(
              child: Container(
                constraints: BoxConstraints(
                    minWidth: 100,
                    maxWidth: size.width * 0.9,
                    minHeight: 100,
                    maxHeight: size.height * 0.9),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon(Icons.close,color: Colors.transparent,),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // IconButton(icon: Icon(Icons.close), onPressed: (){
                          //   Navigator.of(context).pop();
                          // })
                        ],
                      ),
                    ),
                    // SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextField(
                      controller: editingController,
                      maxLines: (isMultiline == true) ? 3 : null,
                      keyboardType: (isOnlyNumbers ?? false)
                          ? TextInputType.number
                          : null,
                      decoration: InputDecoration(
                        hintText: hint ?? '',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          if (secondaryBtnTxt != null)
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorUtil.primoryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    if (secondaryAction != null) {
                                      secondaryAction();
                                    }
                                  },
                                  child: Text(
                                    secondaryBtnTxt,
                                    style: TextStyle(
                                        color: ColorUtil.primoryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          if (secondaryBtnTxt != null)
                            SizedBox(
                              width: 10,
                            ),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: ColorUtil.primoryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if (primaryAction != null) {
                                    primaryAction(editingController.text);
                                  }
                                },
                                child: Text(
                                  primaryBtnTxt,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class CustomPopupList {
  final String title;
  final String message;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final Function(List<String>,String) primaryAction;
  final Function secondaryAction;
  final List<String> texts;

  CustomPopupList(BuildContext context,
      {@required this.title,
        @required this.message,
        @required this.primaryBtnTxt,
        @required this.texts,
        this.secondaryBtnTxt,
        this.primaryAction,
        this.secondaryAction}) {
    final size = MediaQuery
        .of(context)
        .size;

    showDialog(
        context: context,
        builder: (context) {
          return ListViewCheckBox(context, title: title,
            message: message,
            primaryBtnTxt: primaryBtnTxt,
            texts: texts,
            primaryAction: primaryAction,
            secondaryBtnTxt: secondaryBtnTxt,
            secondaryAction: secondaryAction,);
        });
  }
}

class ListViewCheckBox extends StatefulWidget {

  final String title;
  final String message;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final Function(List<String>,String) primaryAction;
  final Function secondaryAction;
  final List<String> texts;

  ListViewCheckBox(BuildContext context,
      {@required this.title,
        @required this.message,
        @required this.primaryBtnTxt,
        @required this.texts,
        this.secondaryBtnTxt,
        this.primaryAction,
        this.secondaryAction});

  @override
  _ListViewCheckBoxState createState() => _ListViewCheckBoxState();
}

class _ListViewCheckBoxState extends State<ListViewCheckBox> {

  List<String> selectedText = [];

  List<String> searchedTexts = [];

  String text = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      searchedTexts = widget.texts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Container(
        constraints: BoxConstraints(
            minWidth: 100,
            maxWidth: size.width,
            minHeight: 100,
            maxHeight: size.height * 0.9),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon(Icons.close,color: Colors.transparent,),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // IconButton(icon: Icon(Icons.close), onPressed: (){
                  //   Navigator.of(context).pop();
                  // })
                ],
              ),
            ),

            Container(
              height: size.height / 3,
              child: Column(
                children: [
                  TextField(
                    onChanged: (text) {
                      this.text = text;
                      if (text.isEmpty) {
                        setState(() {
                          searchedTexts = widget.texts;
                        });
                      } else {
                        setState(() {
                          searchedTexts = widget.texts.where((element) =>
                              element.toLowerCase().contains(
                                  text.toLowerCase())).toList();
                        });
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Search'
                    ),
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          for (String text in searchedTexts) CheckboxListTile(
                            value: selectedText.contains(text),
                            onChanged: (isSelected) {
                              setState(() {
                                if (isSelected) {
                                  selectedText.add(text);
                                } else {
                                  selectedText.remove(text);
                                }
                              });
                            },
                            title: Text('$text'),)
                        ],
                      ))
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  if (widget.secondaryBtnTxt != null)
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: ColorUtil.primoryColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (widget.secondaryAction != null) {
                              widget.secondaryAction();
                            }
                          },
                          child: Text(
                            widget.secondaryBtnTxt,
                            style: TextStyle(
                                color: ColorUtil.primoryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  if (widget.secondaryBtnTxt != null)
                    SizedBox(
                      width: 10,
                    ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: ColorUtil.primoryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (widget.primaryAction != null) {
                            widget.primaryAction(selectedText,this.text);
                          }
                        },
                        child: Text(
                          widget.primaryBtnTxt,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomPopupForActorLink {
  final String title;
  final String titleValue;
  final String linkValue;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final Function(String, String) primaryAction;
  final Function secondaryAction;

  CustomPopupForActorLink(BuildContext context,
      {@required this.title,
        @required this.primaryBtnTxt,
        this.titleValue,
        this.linkValue,
        this.secondaryBtnTxt,
        this.primaryAction,
        this.secondaryAction}) {

    showDialog(
        context: context,
        builder: (context) {
          return ActorLinkPage(context, title: title, primaryBtnTxt: primaryBtnTxt, titleValue: titleValue, linkValue: linkValue, secondaryBtnTxt: secondaryBtnTxt, primaryAction: primaryAction, secondaryAction: secondaryAction);
        });
  }
}

class ActorLinkPage extends StatefulWidget {

  final String title;
  final String titleValue;
  final String linkValue;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final Function(String, String) primaryAction;
  final Function secondaryAction;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  ActorLinkPage(BuildContext context,
      {@required this.title,
        @required this.primaryBtnTxt,
        @required this.titleValue,
        @required this.linkValue,
        @required this.secondaryBtnTxt,
        @required this.primaryAction,
        @required this.secondaryAction});

  @override
  _ActorLinkPageState createState() => _ActorLinkPageState();
}

class _ActorLinkPageState extends State<ActorLinkPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      widget._titleController.text = widget.titleValue;
      widget._linkController.text = widget.linkValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: size.width * 0.9,
              minHeight: 100,
              maxHeight: size.height * 0.9),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(Icons.close,color: Colors.transparent,),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // IconButton(icon: Icon(Icons.close), onPressed: (){
                    //   Navigator.of(context).pop();
                    // })
                  ],
                ),
              ),
              // SizedBox(height: 10,),
              TextField(
                controller: widget._titleController,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: widget._linkController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: 'URL',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    if (widget.secondaryBtnTxt != null)
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: ColorUtil.primoryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (widget.secondaryAction != null) {
                                widget.secondaryAction();
                              }
                            },
                            child: Text(
                              widget.secondaryBtnTxt,
                              style: TextStyle(
                                  color: ColorUtil.primoryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    if (widget.secondaryBtnTxt != null)
                      SizedBox(
                        width: 10,
                      ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: ColorUtil.primoryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (widget.primaryAction != null) {
                              widget.primaryAction(widget._titleController.text,
                                  widget._linkController.text);
                            }
                          },
                          child: Text(
                            widget.primaryBtnTxt,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class CustomPopupForStarRating {
  final String title;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final int starRating;
  final Function(int) primaryAction;
  final Function secondaryAction;

  CustomPopupForStarRating(BuildContext context,
      {this.title,
      this.primaryBtnTxt,
      this.secondaryBtnTxt,
      this.starRating,
      this.primaryAction,
      this.secondaryAction}) {

    showDialog(
        context: context,
        builder: (context) {
          return AddStarRatingPopup(title: title, primaryBtnTxt: primaryBtnTxt, secondaryBtnTxt: secondaryBtnTxt,  secondaryAction: secondaryAction,primaryAction: primaryAction,starRating: starRating,);
        });
  }
}

class AddStarRatingPopup extends StatefulWidget {

  final String title;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final int starRating;
  final Function(int) primaryAction;
  final Function secondaryAction;

  const AddStarRatingPopup({Key key, this.title, this.primaryBtnTxt, this.secondaryBtnTxt, this.starRating, this.primaryAction, this.secondaryAction}) : super(key: key);

  @override
  _AddStarRatingPopupState createState() => _AddStarRatingPopupState();
}

class _AddStarRatingPopupState extends State<AddStarRatingPopup> {

  var output = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      output = widget.starRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: size.width * 0.9,
              minHeight: 100,
              maxHeight: size.height * 0.9),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(Icons.close,color: Colors.transparent,),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // IconButton(icon: Icon(Icons.close), onPressed: (){
                    //   Navigator.of(context).pop();
                    // })
                  ],
                ),
              ),
              // SizedBox(height: 10,),
              Ratings(givenRatings: output,onChange: (stars){
                setState(() {
                  output = stars;
                });
              },),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    if (widget.secondaryBtnTxt != null)
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: ColorUtil.primoryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (widget.secondaryAction != null) {
                                widget.secondaryAction();
                              }
                            },
                            child: Text(
                              widget.secondaryBtnTxt,
                              style: TextStyle(
                                  color: ColorUtil.primoryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    if (widget.secondaryBtnTxt != null)
                      SizedBox(
                        width: 10,
                      ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: ColorUtil.primoryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (widget.primaryAction != null) {
                              widget.primaryAction(output);
                            }
                          },
                          child: Text(
                            widget.primaryBtnTxt,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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