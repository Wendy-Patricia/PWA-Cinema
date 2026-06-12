import 'package:flutter_map/flutter_map.dart';

import '../model/etablissement.dart';
import '../service/etablissement_service.dart';

class EtablissementRepository {

  
  Future<List<Etablissement>> getEtablissements(LatLngBounds bounds) async {
    //return await fetchEtablissements();
    final etablissements = await fetchEtablissements(bounds);
    return etablissements;
  }
}