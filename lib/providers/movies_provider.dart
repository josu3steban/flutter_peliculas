import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/helpers/debouncer.dart';
import 'package:movies/model/model.dart';
import 'package:movies/model/movie_search_response.dart';

class MovieProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey  = 'c48f54b7097fcc3daf7443bc7016ad5d';
  final String _language = 'es-ES';

  final debouncer = Debouncer(duration: const Duration(milliseconds: 200));
  
  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  List<Movie> onStartLoadMovies = [];
  List<Movie> onStartLoadMoviesPopular = [];
  List<Cast> onStartMovieById = [];
  int _popularPage = 0;

  MovieProvider() {
    getStartLoadMovies();
    getStartLoadMoviePopular();
  }

  Future<String> _getData( String enpoint, [int page = 1] ) async{

    final url = Uri.https(_baseUrl, enpoint, {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '$page'
    });

    final response = await http.get(url);
    
    return response.body;
  }

  getStartLoadMovies() async{
    final response = await _getData('3/movie/now_playing');
    final body     = MovieResponse.fromJson(response);
    onStartLoadMovies = body.results;
    notifyListeners();
  }

  getStartLoadMoviePopular() async{
    _popularPage++;
    final response = await _getData('3/movie/popular', _popularPage);
    final body     = MoviesPopularResponse.fromJson(response);
    onStartLoadMoviesPopular = [...onStartLoadMoviesPopular, ...body.results];
    notifyListeners();
  }

  Future<List<Cast>> getStartMovieById(int id) async{

    final response = await _getData('3/movie/$id/credits');
    final body     = MovieByIdResponse.fromJson(response);
    onStartMovieById = body.cast;

    return onStartMovieById;
  }

  Future<List<Movie>> getStartMovieSearch(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key' : _apiKey,
      'language': _language,
      'query'   : query,
      'page'    : '1'
    });

    final response = await http.get(url);
    final body     = MovieSearchResponse.fromJson(response.body);

    return body.results!;
  }

  void getSuggestionByQuery( String searchTerm ) {
    debouncer.value = '';
    debouncer.onValue = (value) async{
      final response = await getStartMovieSearch(value);
      _suggestionStreamController.add(response);
    };

    final timer = Timer.periodic(debouncer.duration, (Timer timer) {
      debouncer.value = searchTerm;
    });

    Future.delayed(debouncer.duration + const Duration(microseconds: 1)).then((value) => timer.cancel());
  }
  
}