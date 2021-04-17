import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soshare/views/screens/category_screen.dart';
import 'package:soshare/views/screens/info_screens.dart';

class InCategory extends StatefulWidget {
  @override
  _InCategoryState createState() => _InCategoryState();
}

class _InCategoryState extends State<InCategory> {
  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance
        .collection('petitions')
        .where('cat', isEqualTo: cat);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('hata ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(' Yükleniyor');
          }

          return Hero(
            tag: 'Icon',
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Material(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('petitions')
                              .doc(document.id)
                              .get()
                              .then((e) {
                            // imgurl = e.data()['imageurl'];
                            // title = e.data()['title'];
                            // bagismi = e.data()['bagis'];
                            // imzami = e.data()['imza'];
                            // subtitle = e.data()['subtitle'];
                          });
                          showAlert(context,document.id);
                        },
                        title: Text(document.data()['title']),
                        subtitle: Text(document.data()['subtitle']),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      document.data()['imageurl']))),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

void showAlert(context,String id) {
  showDialog(context: context, builder: (context) => InfoScreen(documentId: id,));
}
