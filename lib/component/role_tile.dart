import 'package:flutter/material.dart';
import 'package:acteurs/model/role.dart';
import 'package:custom_cached_image/custom_cached_image.dart';
import 'package:acteurs/component/etoiles.dart';

class RoleTile extends StatelessWidget {
  final Role role;

  const RoleTile({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.0),
      child: Row(
        children: [
          Column(
            children: [
              CustomCachedImage(
                imageUrl:
                    'https://img.neotech.fr/cgi/images/tr:quality=50/cinema%2fposters%2f${role.filmId}.jpg',
                width: 70,
                height: 100,
                borderRadius: 5,
                fit: BoxFit.cover,
                errorWidget: Image.asset(
                  'images/profile.jpg',
                  width: 70,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.5,
            
            children: [
              Text(
                role.titre,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                role.alias,
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              Row(
                spacing: 10,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 15,
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                  Text("${role.annee}", style: TextStyle(fontSize: 12)),
                  Icon(
                    Icons.schedule,
                    size: 15,
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                  Text(
                    "${role.duree ~/ 60}h ${role.duree % 60} min",
                    style: TextStyle(fontSize: 12),
                  ),
                  Etoiles(rating: (role.votes ?? 0) / 2),
                ],
              ),
              Text(role.genres.join(', '), style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
