import 'package:cloud_firestore/cloud_firestore.dart';

class Kampanya {
  String id;
  String price;
  String name;
  String img;

  Kampanya(DocumentSnapshot e, {this.id, this.price, this.name, this.img});

  Kampanya.fromMap(DocumentSnapshot snapshot, String id)
      : id = id ?? '',
        name = snapshot.data()['title'] ?? '',
        img = snapshot.data()['imageurl'] ?? '';

  Map<String, String> toJson() {
    return {
      'price': price,
      'name': name,
      'img': img,
    };
  }
}
