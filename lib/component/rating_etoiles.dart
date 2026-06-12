import 'package:flutter/material.dart';

class RatingEtoiles extends StatelessWidget {
  final double? rating;
  final double size;

  const RatingEtoiles({
    super.key,
    this.rating,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    final note = rating ?? 0.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double fillPercent =
            (note - index).clamp(0.0, 1.0);

        return Stack(
          children: [
            Icon(
              Icons.star_border,
              color: Colors.amber,
              size: size,
            ),

            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: fillPercent,
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: size,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}