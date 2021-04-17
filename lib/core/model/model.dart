import 'package:cloud_firestore/cloud_firestore.dart';

class Kampanya {
  String id;
  String price;
  String name;
  String img;
  bool imza;
  bool bagis;
  String content;

  Kampanya(DocumentSnapshot e, {this.id, this.price, this.name, this.img,this.imza,this.bagis,this.content});

  Kampanya.fromMap(DocumentSnapshot snapshot, String id)
      : id = id ?? '',
        name = snapshot.data()['title'] ?? '',
        img = snapshot.data()['imageurl'] ?? '',
        imza = snapshot.data()['imza'] ?? '',
        bagis = snapshot.data()['bagis'] ?? '',
        content = snapshot.data()['subtitle'] ?? '';

  Map<String, String> toJson() {
    return {
      'price': price,
      'name': name,
      'img': img,
    };
  }
}
