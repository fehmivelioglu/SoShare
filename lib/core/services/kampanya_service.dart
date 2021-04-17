import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soshare/core/model/model.dart';

class KampanyaService {
  Future<List<Kampanya>> getKampanya(String id) async {
    var kampanyalar = <Kampanya>[];
    await FirebaseFirestore.instance
        .collection('petitions')
        .doc(id)
        .get()
        .then((e) {
      kampanyalar.add(Kampanya.fromMap(e, 'id'));

      print(kampanyalar.toString() + 'tahsiiin');
    });
    return kampanyalar;
  }
}
