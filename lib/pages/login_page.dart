import 'package:demo_omex_project/model/LoginRes.dart';
import 'package:demo_omex_project/pages/project_page.dart';
import 'package:demo_omex_project/services/userPreferencesService.dart';
import 'package:demo_omex_project/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final dio = new Dio();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset("asset/images/applogo.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter user name'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your secure password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: isLoading
                    ? _buildProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (userNameController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter user name");
                          } else if (passwordController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter password");
                          } else {
                            _LoginUser(userNameController.text,
                                passwordController.text);
                          }
                        },
                        child: Text('Login'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _LoginUser(String userName, String password) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        var url = kBaseUrl + "Login";

        final response = await dio
            .post(url, data: {"UserName": userName, "Password": password});

        var loginRes = LoginRes.fromJson(response.data);

        setState(() {
          isLoading = false;
        });

        switch (loginRes.status) {
          case 1:
            setUi(loginRes.data);
            break;
          case 0:
            Fluttertoast.showToast(msg: loginRes.message);
            break;
        }
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void setUi(Data data) async {
    await UserPreferencesService().setUserLogin(true);
    await UserPreferencesService().setAccesstoken(data.accesstoken);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectScreen(),
      ),
    );
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
}
