import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final MaterialPageRoute route;

  const CircleIcon({super.key, required this.icon, required this.route});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(context, route);
      },
      elevation: 2.0,
      fillColor: Color(0xFF7B2CBF),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
      child: Icon(icon, size: 35.0, color: Colors.white),
    );
  }
}
