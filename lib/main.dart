import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'country.dart';
import 'prediction.dart';
import 'statesdistricts.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Body(),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _getData();
    } else {
      _showAlert(context);
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)),
          title: Text(
            "NO Internet",
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Turn ON Wifi or Mobile Data",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Refresh",
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ));
              },
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('images/coronavirus.png'),
                height: 200.0,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.symmetric(horizontal: 48.0),
              color: Colors.blue[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('images/nation.png'),
                      height: 48.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "INDIA",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.blueAccent[100],
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('images/bluevirus.png'),
                        width: 32.0,
                      ),
                      title: Text(
                        "Confirmed",
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _data[0]['confirmed'],
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.orange[200],
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('images/redvirus.png'),
                        width: 32.0,
                      ),
                      title: Text(
                        "Active",
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _data[0]['active'],
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.green[200],
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('images/greenvirus.png'),
                        width: 32.0,
                      ),
                      title: Text(
                        "Recovered",
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _data[0]['recovered'],
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.red[200],
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('images/blackvirus.png'),
                        width: 32.0,
                      ),
                      title: Text(
                        "Deceased",
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _data[0]['deaths'],
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text("Last Updated " + _data[0]['lastupdatedtime'],
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0)),
            SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  textColor: Colors.black,
                  elevation: 5.0,
                  color: Colors.deepOrange[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Worldwide",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orbitron',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Country()),
                    );
                  },
                ),
                RaisedButton(
                  textColor: Colors.black,
                  elevation: 5.0,
                  color: Colors.deepOrange[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Indian States\n& Districts",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orbitron',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StatesDistricts()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 32.0,
            ),
            RaisedButton(
              textColor: Colors.white,
              elevation: 5.0,
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Our PREDICTIONS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Orbitron',
                    fontSize: 16.0,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Prediction()),
                );
              },
            ),
            SizedBox(
              height: 32.0,
            ),
            Text("Crafted with ♡ by \nArun Vigesh & Manojkumar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Alegreya',
                  fontSize: 12.0,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }

  void _fetchData() async {
    var url = 'https://api.covid19india.org/data.json';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body)['statewise'];
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
