import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Prediction extends StatefulWidget {
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Predictions'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 90.0, vertical: 16.0),
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage('images/pred.png'),
                  height: 100,
                  width: double.infinity,
                ),
              ),
              RaisedButton(
                textColor: Colors.white,
                elevation: 5.0,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Predict Now ... ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Orbitron',
                      fontSize: 16.0,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _data = [];
                    _getData();
                  });
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "ETA = 1 Minute... Don't Leave this Page\nCould be Values @ `End of the Day`",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.red),
              ),
              SizedBox(
                height: 16.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                margin: EdgeInsets.symmetric(horizontal: 48.0),
                color: Colors.teal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('images/located.png'),
                        height: 48.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "All Country",
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 32.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              _data.length != 0
                  ? Expanded(
                child: SizedBox(
                  child: Scrollbar(
                    child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                _data[index]['Country'],
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Alegreya'),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Predicted : " +
                                      _data[index]['Value']
                                          .round()
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              )
                  : Center(child: CircularProgressIndicator()),
            ],
          )),
    );
  }

  void _fetchData() async {
    var url = 'http://34.196.183.102/';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> _getData() async {
    setState(() {
      _fetchData();
    });
  }
}
