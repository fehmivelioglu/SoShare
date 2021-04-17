import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soshare/core/constants/mockData.dart';
import 'package:soshare/views/screens/petitions_screen.dart';
import 'package:soshare/views/widgets/icon_content.dart';

class Kategoriler extends StatelessWidget {
  final MockDatas datas = MockDatas();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildGestureList()),
    );
  }

  List<Row> buildGestureList() {
    var list = <Row>[];
    for (var i = 0; i < 3; i++) {
      list.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildGestureDetector(i)));
    }
    return list;
  }

  List<GestureDetector> buildGestureDetector(int row) {
    var widget = <GestureDetector>[];
    for (var i = 0; i < 3; i++) {
      widget.add(GestureDetector(
        onTap: () =>
            showCategory((row * 3) + i, MockDatas.Kategoriler[(row * i) + i]),
        child: IconContent(
          icon: MockDatas.catIcons[(row * 3) + i],
          label: MockDatas.Kategoriler[(row * 3) + i],
        ),
      ));
    }

    return widget;
  }
}

int cat = 0;
String name = 'Hayvanlar';
Future showCategory(int i, String s) {
  cat = i;
  name = s;
  return Get.to(PetitionsScreen(type: 'cat', appBar: true, cat: cat));
}
