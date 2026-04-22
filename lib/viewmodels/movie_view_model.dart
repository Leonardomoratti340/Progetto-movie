import 'package:flutter/material.dart';
import 'package:progetto_movie/models/movie.dart';
import 'package:progetto_movie/services/movie_service.dart';

class MovieViewModel extends ChangeNotifier {

  final DBService _dbService = DBService();
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  List<Movie> get movies => _filteredMovies;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fecthMovies() async {
    _isLoading = true;
    notifyListeners();
    _movies = await _dbService.getAllMovies();
    _filteredMovies = List.from(_movies);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addMovie(Movie movie) async {
    await _dbService.insertMovie(movie);
    await fecthMovies();
  }

  Future<void> deleteMovie(int id) async {
    await _dbService.deleteMovie(id);
    await fecthMovies();
  }

  Future<void> updateMovie(Movie movie) async {
    if (movie.id == null) return;
    await _dbService.updateMovie(movie);
    await fecthMovies();
  }

  Movie? getMovieById(int id){
    try {
      return _movies.firstWhere((movie) => movie.id == id);
    } catch (_) {
      return null;
    }
  }

  void filterMOvies(String query) {
    if (query.isEmpty) {
      _filteredMovies = List.from(_movies);
    } else {
      _filteredMovies = _movies
          .where(
            (movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()) ||
                movie.plot.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

}