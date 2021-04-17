import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soshare/views/screens/info_screens.dart';

String imgurl;
String title;
String subtitle;
bool bagismi;
bool imzami;

class Bagislar extends StatefulWidget {
  @override
  _BagislarState createState() => _BagislarState();
}

class _BagislarState extends State<Bagislar> {
  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance
        .collection('petitions')
        .where('bagis', isEqualTo: true);

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('hata ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(' Yükleniyor');
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Column(
              children: [
                Hero(
                  tag: 'Icon',
                  child: ListTile(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection('petitions')
                          .doc(document.id)
                          .get()
                          .then((e) {
                        imgurl = e.data()['imageurl'];
                        title = e.data()['title'];
                        bagismi = e.data()['bagis'];
                        imzami = e.data()['imza'];
                        subtitle = e.data()['subtitle'];
                      });
                      await Get.to(InfoScreen());
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
                              image:
                                  NetworkImage(document.data()['imageurl']))),
                    ),
                  ),
                ),
                Divider(),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class Imzalar extends StatefulWidget {
  @override
  _ImzalarState createState() => _ImzalarState();
}

class _ImzalarState extends State<Imzalar> {
  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance
        .collection('petitions')
        .where('imza', isEqualTo: true);

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('hata ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(' Yükleniyor');
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Hero(
              tag: 'Icon',
              child: ListTile(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('petitions')
                      .doc(document.id)
                      .get()
                      .then((e) {
                    imgurl = e.data()['imageurl'];
                    title = e.data()['title'];
                    bagismi = e.data()['bagis'];
                    imzami = e.data()['imza'];
                    subtitle = e.data()['subtitle'];
                  });
                  await Get.to(InfoScreen());
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
                          image: NetworkImage(document.data()['imageurl']))),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class HeroList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deneme'),
      ),
      body: Center(
        child: Hero(
          tag: '',
          child: Image.network('imageurl'),
        ),
      ),
    );
  }
}
