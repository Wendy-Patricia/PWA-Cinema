import 'package:acteurs/model/role.dart';
import 'package:flutter/material.dart';
import 'package:acteurs/repository/role_repository.dart';
import 'package:custom_cached_image/custom_cached_image.dart';

// lien img : https://img.neotech.fr/cgi/images/tr:quality=50/cinema%2fprofiles%2f2.jpg

//classe d Ã©tat pour gÃ©rer les donnÃ©es qui vont changer
class RoleView extends StatefulWidget {
  const RoleView({super.key, required this.personneId, required this.nom});

  final String nom;
  final int personneId;

  @override
  State<RoleView> createState() => _RoleViewState();
}

//et un classe du widget
//le build est obligatoire
// _ underscore indique que la classe est privÃ©e
class _RoleViewState extends State<RoleView> {
  late Future<List<Role>> _futureRoleView;
  final RoleRepository _repository = RoleRepository();

  @override
  void initState() {
    super.initState();
    _futureRoleView = _repository
        .getRoles(widget.personneId); //on affiche la liste des roles dans la console
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold = squelette de l'application
      appBar: AppBar(title: Text(widget.nom)),
      body: FutureBuilder(
        future: _futureRoleView,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun role trouvÃ©'));
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erreur de communication'));
          }

          final roles =
              snapshot.data!; // "!" pour dire que data n'est pas null
          return ListView.builder(
            itemCount: roles.length, //nombre d'éléments dans la liste
            itemBuilder: (context, index) {
              //itemBuilder = fonction pour construire une ligne
              return ListTile(
                title: Text(roles[index].titre), //titre
                subtitle: Text(
                  "${roles[index].alias} / ${roles[index].duree} minutes",
                ), //sous-titre
                leading: CustomCachedImage(
                  imageUrl:
                      'https://img.neotech.fr/cgi/images/tr:quality=50/cinema%2fposters%2f${roles[index].filmId}.jpg',
                  width: 41,
                  height: 41,
                  borderRadius: 21,
                  fit: BoxFit.cover,
                  errorWidget: Image.asset( 'images/profile.jpg', width: 41, height: 41, fit: BoxFit.cover)
                ),
              ); 
              //tuile
            },
          );
        },
      ),
    );
  }
}
