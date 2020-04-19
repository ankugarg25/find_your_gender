import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// gender checker
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.fallback(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  var result;

  predictGender(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var res = await http.get(url);
    var body = jsonDecode(res.body);

    result = "Gender: ${body['gender']}, Probability: ${body['probability']}";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gender Predictor"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Enter your name for predicting your gender.",style: new TextStyle(fontStyle: FontStyle.italic,color: Colors.black,fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
            RaisedButton(
              onPressed: () => predictGender(_nameController.text),
              child: Text("PREDICT"),
            ),
            if (result != null) Text(result)
          ],
        ),
      ),
    );
  }
}
