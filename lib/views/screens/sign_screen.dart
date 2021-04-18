import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soshare/views/screens/home_screen.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

final cont1 = TextEditingController();
final cont2 = TextEditingController();
int category = 0;
bool bagis = false;
bool imza = false;

class _SignPageState extends State<SignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İmzalama Ekranı'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
              child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 90),
            child: Column(children: [
              TextField(controller: cont1, decoration: decor('Isım Soyisim')),
              Container(
                height: 10,
              ),
              TextField(controller: cont2, decoration: decor('Email')),
              Container(
                height: 10,
              ),
              TextField(controller: cont2, decoration: decor('Telefon numarası')),
              Container(height: 100),
              TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                            height: 50, child: Text('İmzanız alınmıştır.'))));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                  },
                  child: Text('İmzala')),
            ]),
          ),
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
