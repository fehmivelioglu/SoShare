import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soshare/core/model/kampanya_model.dart';
import 'package:soshare/views/screens/category_screen.dart';
import 'package:soshare/views/screens/info_screens.dart';

class PetitionsScreen extends StatefulWidget {
  final String type;
  final bool appBar;
  final int cat;

  const PetitionsScreen(
      {Key key, @required this.type, this.appBar = false, this.cat})
      : super(key: key);
  @override
  _PetitionsScreenState createState() => _PetitionsScreenState();
}

class _PetitionsScreenState extends State<PetitionsScreen> {
  List<Kampanya> degisken = [];

  @override
  Widget build(BuildContext context) {
    var petitionscol = FirebaseFirestore.instance
        .collection('petitions')
        .where(widget.type, isEqualTo: widget.appBar ? widget.cat : true);

    return Scaffold(
      appBar: widget.appBar
          ? AppBar(
              title: Text(name),
              centerTitle: true,
            )
          : null,
      body: StreamBuilder<QuerySnapshot>(
        stream: petitionscol.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('hata ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Column(
                children: [
                  ListTile(
                    onTap: () async {
                      await Get.to(InfoScreen(
                        documentId: document.id,
                      ));
                    },
                    title: Text(document.data()['title']),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  NetworkImage(document.data()['imageurl']))),
                    ),
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
