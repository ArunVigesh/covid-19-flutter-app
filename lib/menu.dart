import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.white, Colors.grey],
          begin: const FractionalOffset(0.5, 0.0),
          end: const FractionalOffset(0.0, 0.5),
          stops: [0.0, 1.0],
        )),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Covid 19!",
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Alegreya'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Developers",
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Orbitron'),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Center(
                        child: Text(
                      "Arun Vigesh V G",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    )),
                    subtitle: InkWell(
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "arunvigesh.github.io",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blueAccent),
                        ),
                      )),
                      onTap: () async {
                        if (await canLaunch("http://arunvigesh.github.io")) {
                          await launch("http://arunvigesh.github.io");
                        }
                      },
                    ),
                  )),
                  Expanded(
                    child: ListTile(
                      title: Center(
                          child: Text(
                        "Manojkumar V K",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      )),
                      subtitle: InkWell(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "vkmanojk.github.io",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueAccent),
                          ),
                        )),
                        onTap: () async {
                          if (await canLaunch("http://vkmanojk.github.io")) {
                            await launch("http://vkmanojk.github.io");
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "About",
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Orbitron'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "\t\t The android application acts as a portal for the public to keep track of COVID-19, alongside collecting data for further analysis. All the contents are handpicked and filtered to our best extent to ensure that sources are reliable with minimal hoaxes, in the best benefit of the public. Auto Regressive Integrated Moving Average(ARIMA) is used to analyze the trend in the number of daily coronavirus cases across the country prior to being verified by our team. We also aim to gather data for in-depth analysis (e.g. time series to monitor the growth, spread of the virus).",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Unique Features",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "- Track daily coronavirus cases across world.\n - Keep tabs on the increase or decrease of the number of cases in your district. \n - Amaze your friends and family by prognosticating the number of corona cases in any country at the end of the day.",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
