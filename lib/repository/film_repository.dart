import '../model/film.dart';
import '../service/film_service.dart';

class FilmRepository {
  Future<List<Film>> getFilms(int filmId) async {
    final films = await fetchFilms(filmId);
    return films;
  }
}
