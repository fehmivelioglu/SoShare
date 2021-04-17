import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soshare/views/screens/info_screens.dart';

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

        //Hero olmamış gibi?


        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Column(
              children: [
                Hero(
                  tag: 'Icon',
                  child: ListTile(
                   onTap: (){
                     setState(() {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => InfoScreen()),
                       );
                     });
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


class HeroList extends StatelessWidget {
  @override
  Widget  build(BuildContext context) {
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