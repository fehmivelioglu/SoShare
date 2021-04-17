import 'package:flutter/material.dart';
import 'package:soshare/views/const.dart';
import 'package:soshare/views/screens/first_screen.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Deneme'),
          centerTitle: true,
        ),
        body: Hero(
            tag: 'Icon',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RowWidget(),
                Expanded(child: Text(subtitle)),
                Buttons()
              ],
            )));
  }
}

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (imzami == true && bagismi == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => null, child: Text('Bağış Yap')),
          TextButton(onPressed: () => null, child: Text('İmzala'))
        ],
      );
    } else if (imzami == false && bagismi == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TextButton(onPressed: () => null, child: Text('Bağış Yap'))],
      );
    } else if (imzami == true && bagismi == false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TextButton(onPressed: () => null, child: Text('İmzala'))],
      );
    } else {
      return Container();
    }
  }
}

class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(imgurl))),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title.toUpperCase(),
            style: kHeightTextStyle,
          )
        ],
      ),
    );
  }
}
