import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatesDistricts extends StatefulWidget {
  @override
  _StatesDistrictsState createState() => _StatesDistrictsState();
}

class _StatesDistrictsState extends State<StatesDistricts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian States & Districts'),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('images/india.png'),
              height: 240,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                textColor: Colors.white,
                elevation: 10.0,
                color: Colors.orangeAccent[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "States",
                    style: TextStyle(fontSize: 32.0, fontFamily: 'Orbitron'),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => States()),
                  );
                }),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              textColor: Colors.white,
              elevation: 10.0,
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Districts",
                  style: TextStyle(fontSize: 32.0, fontFamily: 'Orbitron'),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Districts()),
                );
              },
            ),
          ),
          SizedBox(
            height: 16.0,
          )
        ],
      )),
    );
  }
}

class States extends StatefulWidget {
  @override
  _StatesState createState() => _StatesState();
}

class _StatesState extends State<States> {
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
        title: Text("Indian States"),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 32.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.symmetric(horizontal: 32.0),
              color: Colors.blue[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('images/nation.png'),
                      height: 32.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Indian States",
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            _data.length != 0
                ? Expanded(
                    child: SizedBox(
                      child: RefreshIndicator(
                          child: Scrollbar(
                            child: ListView.builder(
                                padding: EdgeInsets.all(8),
                                itemCount: _data.length - 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: <Widget>[
                                        Text(
                                          _data[index + 1]['state'],
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Alegreya'),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Confirmed : " +
                                                    _data[index + 1]
                                                        ['confirmed'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Active : " +
                                                    _data[index + 1]['active'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Recovered : " +
                                                    _data[index + 1]
                                                        ['recovered'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Deceased : " +
                                                    _data[index + 1]['deaths'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "Last Updated " +
                                                  _data[index + 1]
                                                      ['lastupdatedtime'],
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 12.0)),
                                        ),
                                      ]),
                                    ),
                                  );
                                }),
                          ),
                          onRefresh: _getData),
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
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

class Districts extends StatefulWidget {
  @override
  _DistrictsState createState() => _DistrictsState();
}

class _DistrictsState extends State<Districts> {
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
        title: Text("Indian Districts"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.blue[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('images/nation.png'),
                      height: 32.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Indian Districts",
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
                      child: RefreshIndicator(
                          child: Scrollbar(
                            child: ListView.builder(
                                padding: EdgeInsets.all(8),
                                itemCount: _data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: <Widget>[
                                        ExpansionTile(
                                          title: Text(
                                            _data[index]['state'],
                                            style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Alegreya'),
                                          ),
                                          children: <Widget>[
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: _data[index]
                                                        ['districtData']
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index2) {
                                                  return Column(
                                                    children: <Widget>[
                                                      Text(
                                                        _data[index]
                                                                ['districtData']
                                                            [
                                                            index2]['district'],
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Alegreya'),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Confirmed : " +
                                                                  _data[index]['districtData']
                                                                              [
                                                                              index2]
                                                                          [
                                                                          'confirmed']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Active : " +
                                                                  _data[index]['districtData']
                                                                              [
                                                                              index2]
                                                                          [
                                                                          'active']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .orange),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Recovered : " +
                                                                  _data[index]['districtData']
                                                                              [
                                                                              index2]
                                                                          [
                                                                          'recovered']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Deceased : " +
                                                                  _data[index]['districtData']
                                                                              [
                                                                              index2]
                                                                          [
                                                                          'deceased']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  );
                                }),
                          ),
                          onRefresh: _getData),
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  void _fetchData() async {
    var url = 'https://api.covid19india.org/v2/state_district_wise.json';
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
