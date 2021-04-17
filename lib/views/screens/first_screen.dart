import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bagislar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance
        .collection('petitions')
        .where('category', isEqualTo: 0);

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
                ListTile(
                  onTap: () => null,
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
                Divider(),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class Imzalar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance
        .collection('petitions')
        .where('category', isEqualTo: 1);

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
            return ListTile(
              onTap: () => null,
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
            );
          }).toList(),
        );
      },
    );
  }
}
