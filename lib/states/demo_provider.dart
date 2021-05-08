import 'package:flutter/material.dart';

class DemoProdiver extends StatefulWidget {
  @override
  _DemoProdiverState createState() => _DemoProdiverState();
}

class _DemoProdiverState extends State<DemoProdiver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo Provider'),),
      body: Text('Demo Provider'),
    );
  }
}