import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jewelbook_calculator/ui/dashboard/dataStream.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DataStream _dataStream;
  late StreamSubscription<String> _subscription;
  String _latestData = "";

  @override
  void initState() {
    super.initState();
    _dataStream = DataStream();
    _dataStream.start();
    _subscription = _dataStream.stream.listen((data) {
      setState(() {
        _latestData = data;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _dataStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Text Stream'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            _latestData,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange.shade900,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dataStream.start();
        },
        child: Icon(Icons.refresh),
        backgroundColor: Colors.deepOrange.shade900,
      ),
    );
  }
}
