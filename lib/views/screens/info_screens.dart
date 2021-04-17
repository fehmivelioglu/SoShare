import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deneme'),
      ),
      body: Hero(
        tag: 'Icon',
        child: Container(
          child: Column(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}