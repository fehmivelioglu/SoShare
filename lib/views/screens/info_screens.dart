import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soshare/views/screens/donate_screen.dart';
import 'package:soshare/views/screens/sign_screen.dart';

import '../../core/model/kampanya_model.dart';
import '../../core/services/kampanya_service.dart';
import 'package:auto_size_text/auto_size_text.dart';

class InfoScreen extends StatefulWidget {
  final String documentId;

  const InfoScreen({Key key, @required this.documentId}) : super(key: key);
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final KampanyaService _kampanyaService = KampanyaService.instance;
  Future _future;
  List<Kampanya> _kampanyalar = [];
  @override
  void initState() {
    super.initState();
    _future = _kampanyaService.getKampanya(widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kampanya Detayları'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _kampanyalar = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RowWidget(kampanya: _kampanyalar[0]),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Content(kampanyalar: _kampanyalar)),
                          Buttons(kampanya: _kampanyalar[0]),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}

class Content extends StatelessWidget {
  const Content({
    Key key,
    @required List<Kampanya> kampanyalar,
  })  : _kampanyalar = kampanyalar,
        super(key: key);

  final List<Kampanya> _kampanyalar;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: AutoSizeText(
          _kampanyalar[0].content,
          minFontSize: 18,
          style: TextStyle(
            height: 1.8,
          ),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final Kampanya kampanya;

  const Buttons({Key key, this.kampanya}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        kampanya.bagis ? buttonContainer(0, 'Bağış Yap') : Center(),
        kampanya.bagis && kampanya.imza ? Container(width: 15,):Container(),
        kampanya.imza ? buttonContainer(1, 'İmzala') : Center()
      ],
    );
  }

  Container buttonContainer(int index, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.black38, borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {
            if (index == 0) {
              Get.off(DonatePage());
            } else {
              Get.off(SignPage());
            }
          },
          child: Text(
            title,
            style: TextStyle(fontSize: 15),
          )),
    );
  }
}

class RowWidget extends StatelessWidget {
  final Kampanya kampanya;

  const RowWidget({Key key, this.kampanya}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black38),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(kampanya.img))),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            // height: 100,
            child: Text(
              kampanya.name, style: TextStyle(fontSize: 18),
              // maxLines: 3,
            ),
          )
        ],
      ),
    );
  }
}
