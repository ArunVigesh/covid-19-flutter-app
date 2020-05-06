import 'package:flutter/material.dart';

class Prediction extends StatefulWidget {
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our PREDICTIONS'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Center(child: Text("Prediction....\nIn Progress")),
      ),
    );
  }
}
