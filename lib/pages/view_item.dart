import 'package:flutter/material.dart';

class ViewItemScreen extends StatefulWidget {
  const ViewItemScreen({Key key}) : super(key: key);

  @override
  _ViewItemScreenState createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requirements Details"),
      ),
      body: SafeArea(
        child: Container(
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "Short Description : It is a long established fact that a reader will be distracted"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "Long Description : It is a long established fact that a reader will be distracted. It is a long established fact that a reader will be distracted. It is a long established fact that a reader will be distracted"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
