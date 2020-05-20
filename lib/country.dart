import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  List<dynamic> _data = [];
  List<String> _countryNames = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worldwide'),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('images/world.png'),
                height: 120,
                width: double.infinity,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.symmetric(horizontal: 48.0),
              color: Colors.deepOrange[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('images/allcountry.png'),
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
                      child: RefreshIndicator(
                          child: Scrollbar(
                            child: ListView.builder(
                                padding: EdgeInsets.all(8),
                                itemCount: _data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Row(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image(
                                          width: 48.0,
                                          image: NetworkImage(_data[index]
                                              ['countryInfo']['flag']),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: <Widget>[
                                          Text(
                                            _data[index]['country'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Alegreya'),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Confirmed : " +
                                                      _data[index]['cases']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Active : " +
                                                      _data[index]['active']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Recovered : " +
                                                      _data[index]['recovered']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Deceased : " +
                                                      _data[index]['deaths']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ]),
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
    var url = 'https://corona.lmao.ninja/v2/countries?today=&sort=';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body);
      });
      _countryNames.clear();
      for (int i = 0; i < _data.length; i++) {
        _countryNames.add(_data[i]['country']);
      }
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
