import 'package:demo_omex_project/pages/login_page.dart';
import 'package:demo_omex_project/pages/project_page.dart';
import 'package:demo_omex_project/services/userPreferencesService.dart';
import 'package:flutter/material.dart';

class LendingScreen extends StatefulWidget {
  const LendingScreen({Key key}) : super(key: key);

  @override
  _LendingScreenState createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen> {
  bool isUserLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocalUser();
  }

  @override
  Widget build(BuildContext context) {
    if (isUserLogin == null) {
      return Container(color: Colors.black);
    } else {
      if (isUserLogin) {
        return ProjectScreen();
      } else {
        return LoginPage();
      }
    }
  }

  void getLocalUser() async {
    var isLogin = await UserPreferencesService().isUserLogin();
    setState(() {
      isUserLogin = isLogin ?? false;
    });
  }
}
