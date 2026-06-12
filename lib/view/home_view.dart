
import 'package:acteurs/component/circle_icon.dart';
import 'package:acteurs/view/acteur_view.dart';
import 'package:acteurs/view/carte_view.dart';
import 'package:acteurs/view/quiz_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatelessWidget {
  //stateless = woidget sans état

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //permettra de construire le widget
    return Scaffold (
      body: Column(
      children: [
        Container (  
        width: double.infinity,
        padding: EdgeInsets.only(top: 1, bottom: 0.2), 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7B2CBF),
              Color(0xFF240046),]
          ),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(300,80)
          )
        ),
        child:Column(
        children:[
            Text('Cinéma', style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows:[Shadow(
                blurRadius: 4,
                color: Colors.black45,
                offset: Offset(1, 2)
              )]
            )),
            SvgPicture.asset('assets/cinema.svg',
            height: 300,
            width: 300,),
        ])
        ,),
        SizedBox(height: 30,), //espace entre les éléments
        Row ( 
          mainAxisAlignment: MainAxisAlignment.spaceAround, //espacement entre les éléments
          children: [
          CircleIcon(icon: Icons.location_on, route: MaterialPageRoute(builder: (context) => CarteView())),
          CircleIcon(icon: Icons.theater_comedy, route: MaterialPageRoute(builder: (context) => ActeurView())),
          CircleIcon(icon: Icons.local_activity, route: MaterialPageRoute(builder: (context) => QuizHomeView())),
          CircleIcon(icon: Icons.theaters, route: MaterialPageRoute(builder: (context) => ActeurView())),
        ],)
        ],
    ));
  }
}

