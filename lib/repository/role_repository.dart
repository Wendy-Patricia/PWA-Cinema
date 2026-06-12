import '../model/role.dart';
import '../service/role_service.dart';

class RoleRepository {
  Future<List<Role>> getRoles(int personneId) async {
    final roles = await fetchRoles(personneId);
    roles.sort(
      (a, b) => switch ((a.annee, b.annee)) {
        (null, null) => 0,
        (null, _) => 1,
        (_, null) => -1,
        (final annee1, final annee2) => annee1.compareTo(annee2),
      },
    );
    return roles;
  }
}
