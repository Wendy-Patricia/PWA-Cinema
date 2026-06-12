import 'package:acteurs/repository/etablissement_repository.dart';
import 'package:acteurs/service/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class CarteView extends StatefulWidget {

  const CarteView({super.key});

  @override
  State<StatefulWidget> createState() => _CarteViewState();
}

// Classe privée commence par _ underscore. Ne peit pas être utilisée à l'ext du fichier carte_view.dart
class _CarteViewState extends State<CarteView> {
  
  final _mapController = MapController();
  final _repository = EtablissementRepository();
  List<Marker> _markers = [];
  final _debouncer = Debouncer(delais: Duration(milliseconds: 300));

  @override void initState() {
    super.initState();
    _determinePosition().then( (Position p) {
      setState(() {
        _mapController.move(LatLng(p.latitude, p.longitude), 13);
      });
    });
  }
  
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _appelService() {
    _repository.getEtablissements(_mapController.camera.visibleBounds)
      .then( (etablissements) {
        // Transforme mes établissements en liste de Marker
        final liste = etablissements.map( (e) => Marker(
          point: e.point,
          child: Icon(Icons.location_pin)
        ));

        setState(() {
          _markers = liste.toList();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Color.fromARGB(255, 255, 143, 176),
          title:Text("Carte")
        ),
        body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: LatLng(51.509364, -0.128928), // Center the map over London, UK
            initialZoom: 9.2,
            onPositionChanged: (position, hasGesture) {
              _debouncer.run(_appelService);
            }
          ),
          children: [
            TileLayer( // Bring your own tiles
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
              userAgentPackageName: "univ-lorraine.iutsd.cinema",
            ),
            MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 150,
              size: const Size(40, 40),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50),
              maxZoom: 15,        
              markers: _markers,
              builder: (context, markers) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 244, 199, 231)),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
            RichAttributionWidget( 
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                ),
                // Also add images...
              ],
            ),
          ],
        ) 
    );  
  }
}
