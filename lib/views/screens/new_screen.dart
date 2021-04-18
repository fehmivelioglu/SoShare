import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soshare/views/screens/home_screen.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

final cont1 = TextEditingController();
final cont2 = TextEditingController();
int category = 0;
bool bagis = false;
bool imza = false;

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(28.0),
          child: Column(children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropDownCategoryOne(),
                  DropDownCategoryTwo(),
                ],
              ),
            ),
            TextField(controller: cont1, decoration: decor('title')),
            TextField(controller: cont2, decoration: decor('subtitle')),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        addUser(cont1.text, cont2.text, category, imza, bagis);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                        cont1.clear();
                        cont2.clear();
                      },
                      child: Text('Kampanya Başlat')),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class DropDownCategoryOne extends StatefulWidget {
  @override
  _DropDownCategoryOneState createState() => _DropDownCategoryOneState();
}

class _DropDownCategoryOneState extends State<DropDownCategoryOne> {
  int _value;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<int>(
        items: [
          DropdownMenuItem<int>(value: 0, child: Text('Hayvanlar')),
          DropdownMenuItem<int>(value: 1, child: Text('Ekonomi')),
          DropdownMenuItem<int>(value: 2, child: Text('Sağlık')),
          DropdownMenuItem<int>(value: 3, child: Text('Eğitim')),
          DropdownMenuItem<int>(value: 4, child: Text('Çevre')),
          DropdownMenuItem<int>(value: 5, child: Text('Adalet')),
          DropdownMenuItem<int>(value: 6, child: Text('İnsan Hakları')),
          DropdownMenuItem<int>(value: 7, child: Text('Gıda')),
          DropdownMenuItem<int>(value: 8, child: Text('Diğer'))
        ],
        onChanged: (int value) {
          setState(() {
            category = value;
            _value = value;
          });
        },
        value: _value,
        hint: Text('Kategori'),
      ),
    );
  }
}

class DropDownCategoryTwo extends StatefulWidget {
  @override
  _DropDownCategoryTwoState createState() => _DropDownCategoryTwoState();
}

class _DropDownCategoryTwoState extends State<DropDownCategoryTwo> {
  int _value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      items: [
        DropdownMenuItem<int>(value: 0, child: Text('Bağış')),
        DropdownMenuItem<int>(value: 1, child: Text('İmza')),
        DropdownMenuItem<int>(value: 2, child: Text('Her ikisi')),
      ],
      value: _value,
      onChanged: (int value) {
        setState(() {
          if (value == 0) {
            bagis = true;
            imza = false;
            _value = value;
          } else if (value == 1) {
            bagis = false;
            imza = true;
            _value = value;
          } else if (value == 2) {
            bagis = true;
            imza = true;
            _value = value;
          }
        });
      },
      hint: Text('Tip'),
    );
  }
}

Future<void> addUser(
  String title,
  String subtitle,
  int cat,
  bool imza,
  bool bagis,
) {
  return FirebaseFirestore.instance
      .collection('petitions')
      .add({
        'cat': cat,
        'imza': imza,
        'bagis': bagis,
        'imageurl': 'https://picsum.photos/200',
        'title': title,
        'subtitle': subtitle,
      })
      .then((value) => print('User Added'))
      .catchError((error) => print('Failed to add user: {$error}'));
}

dynamic decor(String label) {
  return InputDecoration(
    labelText: label,
  );
}
