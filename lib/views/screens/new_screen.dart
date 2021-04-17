import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

final cont0 = TextEditingController();
final cont1 = TextEditingController();
final cont2 = TextEditingController();
final cont3 = TextEditingController();
final cont4 = TextEditingController();
final cont5 = TextEditingController();
final cont6 = TextEditingController();
final wordlistcoll = FirebaseFirestore.instance.collection('wordlist');
int size = 5;

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(controller: cont6, decoration: decor('id')),
          TextField(controller: cont0, decoration: decor('kelime')),
          TextField(controller: cont1, decoration: decor('1')),
          TextField(controller: cont2, decoration: decor('2')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () async {
                    await addUser();
                  },
                  child: Text('Kelime Ekle')),
            ],
          ),
        ]),
      ),
    );
  }
}

Future<void> addUser() {
  return FirebaseFirestore.instance
      .collection('petitions')
      .add({
        'category': 0,
        'imageurl': 'https://picsum.photos/200',
        'title': 'title123123',
        'subtitle': 'subtitel13213',
      })
      .then((value) => print('User Added'))
      .catchError((error) => print('Failed to add user: {$error}'));
}

dynamic decor(String label) {
  return InputDecoration(
    labelText: label,
  );
}
