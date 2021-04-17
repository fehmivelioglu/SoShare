import 'package:flutter/material.dart';
import 'package:soshare/core/constants/const.dart';
import 'package:soshare/core/model/model.dart';
import 'package:soshare/core/services/kampanya_service.dart';

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
        body: Hero(
            tag: 'Icon',
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _kampanyalar = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RowWidget(kampanya: _kampanyalar[0]),
                      Expanded(child: Text(_kampanyalar[0].content)),
                      Buttons(kampanya: _kampanyalar[0]),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            )));
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
          TextButton(onPressed: () => null, child: Text('Bağış Yap')),
          TextButton(onPressed: () => null, child: Text('İmzala'))
        ],
      );
    } else if (kampanya.imza == false && kampanya.bagis == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TextButton(onPressed: () => null, child: Text('Bağış Yap'))],
      );
    } else if (kampanya.imza == true && kampanya.bagis == false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TextButton(onPressed: () => null, child: Text('İmzala'))],
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          Text(
            kampanya.name.toUpperCase(),
            style: AppConstants.kHeightTextStyle,
          )
        ],
      ),
    );
  }
}
