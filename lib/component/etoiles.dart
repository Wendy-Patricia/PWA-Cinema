import 'package:flutter/material.dart';

class Etoiles extends StatelessWidget {
  final double rating;

  const Etoiles({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(Icons.star, color: Colors.grey.shade200);
          }),
        ),
        Row(
          children: List.generate((5), (index) {
            final pourcentage = (rating - index).clamp(0.0, 1.0);

            return ClipRect(
              clipper: DecoupeEtoiles(pourcentage),
              child: Icon(Icons.star, color: Colors.yellow.shade400),
            );
          }),
        ),
      ],
    );
  }
}

class DecoupeEtoiles extends CustomClipper<Rect> {
  final double pourcentage;

  DecoupeEtoiles(this.pourcentage);

  //On dessign le rectangle qui decoupe l'etoile en fonction du pourcentage de remplissage de l'etoile
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant DecoupeEtoiles oldClipper) {
    return oldClipper.pourcentage != pourcentage;
  }
}
