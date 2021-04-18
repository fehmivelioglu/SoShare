import 'package:flutter/material.dart';
import 'package:soshare/views/screens/donate_screen.dart';
import 'package:soshare/views/screens/sign_screen.dart';

import '../../core/constants/const.dart';
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
          title: Text('Deneme'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _kampanyalar = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RowWidget(kampanya: _kampanyalar[0]),
                  Expanded(child: Content(kampanyalar: _kampanyalar)),
                  Buttons(kampanya: _kampanyalar[0]),
                ],
              );
            }
            return CircularProgressIndicator();
          },
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
    return Container(
      padding: EdgeInsets.all(15),
      child: Center(
        child: AutoSizeText(
          _kampanyalar[0].content,
          minFontSize: 15,
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
    if (kampanya.imza == true && kampanya.bagis == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DonatePage()),
        );
      }, child: Text('Bağış Yap')),
          TextButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignPage()),
            );
          }, child: Text('İmzala'))
        ],
      );
    } else if (kampanya.imza == false && kampanya.bagis == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TextButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DonatePage()),
        );
      }, child: Text('Bağış Yap'))],
      );
    } else if (kampanya.imza == true && kampanya.bagis == false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TextButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignPage()),
          );
        }, child: Text('İmzala'))],
      );
    } else {
      return Container();
    }
  }
}

class RowWidget extends StatelessWidget {
  final Kampanya kampanya;

  const RowWidget({Key key, this.kampanya}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
          Center(
            // height: 100,
            child: AutoSizeText(
              kampanya.name,
              // maxLines: 3,
            ),
          )
        ],
      ),
    );
  }
}
