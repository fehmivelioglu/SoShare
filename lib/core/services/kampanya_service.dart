import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soshare/core/model/kampanya_model.dart';

class KampanyaService {
  static KampanyaService _instance;
  static KampanyaService get instance {
    _instance ??= KampanyaService._init();
    return _instance;
  }

  KampanyaService._init();
  Future<List<Kampanya>> getKampanya(String id) async {
    var kampanyalar = <Kampanya>[];
    await FirebaseFirestore.instance
        .collection('petitions')
        .doc(id)
        .get()
        .then((e) {
      kampanyalar.add(Kampanya.fromMap(e, 'id'));
    });
    return kampanyalar;
  }
}
