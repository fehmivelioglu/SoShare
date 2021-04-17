import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soshare/views/screens/incategory_screen.dart';

class Kategoriler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => showCategory(0, 'Hayvanlar'),
                child: IconContent(
                  icon: Icons.pets,
                  label: 'Hayvanlar',
                ),
              ),
              GestureDetector(
                onTap: () => showCategory(1, 'Ekonomi'),
                child: IconContent(
                  icon: Icons.account_balance,
                  label: 'Ekonomi',
                ),
              ),
              GestureDetector(
                onTap: () => showCategory(2, 'Sağlık'),
                child: IconContent(
                  icon: Icons.favorite,
                  label: 'Sağlık',
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => showCategory(3, 'Eğitim'),
                child: IconContent(
                  icon: Icons.school,
                  label: 'Eğitim',
                ),
              ),
              GestureDetector(
                onTap: () => showCategory(4, 'Çevre'),
                child: IconContent(
                  icon: Icons.public,
                  label: 'Çevre',
                ),
              ),
              GestureDetector(
                onTap: () => showCategory(5, 'Adalet'),
                child: IconContent(
                  icon: Icons.gavel,
                  label: 'Adalet',
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => showCategory(6, 'İnsan Hakları'),
                child: IconContent(
                  icon: Icons.people,
                  label: 'İnsan Hakları',
                ),
              ),
              GestureDetector(
                onTap: () => showCategory(7, 'Gıda'),
                child: IconContent(
                  icon: Icons.fastfood,
                  label: 'Gıda',
                ),
              ),
              GestureDetector(
                onTap: () => showCategory(8, 'Diğer'),
                child: IconContent(
                  icon: Icons.timeline,
                  label: 'Diğer',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

int cat = 0;
String name = 'Hayvanlar';
Future showCategory(int i, String s) {
  cat = i;
  name = s;
  return Get.to(InCategory());
}

class IconContent extends StatelessWidget {
  IconContent({@required this.icon, this.label});

  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.black45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
