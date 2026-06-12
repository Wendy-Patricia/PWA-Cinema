import 'package:acteurs/model/acteur.dart';
import 'package:flutter/material.dart';
import 'package:acteurs/repository/acteur_repository.dart';
import 'package:acteurs/view/role_view.dart';
import 'package:custom_cached_image/custom_cached_image.dart';

// lien img : https://img.neotech.fr/cgi/images/tr:quality=50/cinema%2fprofiles%2f2.jpg

//classe d Ã©tat pour gÃ©rer les donnÃ©es qui vont changer
class ActeurView extends StatefulWidget {
  const ActeurView({super.key});

  @override
  State<ActeurView> createState() => _ActeurViewState();
}

//et un classe du widget
//le build est obligatoire
// _ underscore indique que la classe est privÃ©e
class _ActeurViewState extends State<ActeurView> {
  late Future<List<Acteur>> _futureActeurs;
  final ActeurRepository _repository = ActeurRepository();

  @override
  void initState() {
    super.initState();
    _futureActeurs = _repository
        .getActeurs(); //on affiche la liste des acteurs dans la console
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold = squelette de l'application
      appBar: AppBar(title: Text("Acteurs")),
      body: FutureBuilder(
        future: _futureActeurs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun acteur trouvÃ©'));
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erreur de communication'));
          }

          final acteurs =
              snapshot.data!; // "!" pour dire que data n'est pas null
          return ListView.builder(
            itemCount: acteurs.length, //nombre d'Ã©lÃ©ments dans la liste
            itemBuilder: (context, index) {
              //itemBuilder = fonction pour construire une ligne
              return ListTile(
                title: Text(acteurs[index].nom), //titre
                subtitle: Text(
                  "${acteurs[index].drapeauUnicode} ${acteurs[index].age} ans / ${acteurs[index].nbFilm} films",
                ), //sous-titre
                leading: CustomCachedImage(
                  imageUrl:
                      'https://img.neotech.fr/cgi/images/tr:quality=50/cinema%2fprofiles%2f${acteurs[index].personneId}.jpg',
                  width: 41,
                  height: 41,
                  borderRadius: 21,
                  fit: BoxFit.cover,
                  errorWidget: Image.asset(
                    'images/profile.jpg',
                    width: 41,
                    height: 41,
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RoleView(
                        personneId: acteurs[index].personneId,
                        nom: acteurs[index].nom,
                      ),
                    ),
                  );
                },
              ); //tuile
            },
          );
        },
      ),
    );
  }
}
