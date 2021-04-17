import 'package:flutter/material.dart';

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
