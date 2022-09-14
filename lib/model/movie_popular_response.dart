// To parse this JSON data, do
//
//     final moviesPopularResponse = moviesPopularResponseFromMap(jsonString);

import 'dart:convert';

import 'package:movies/model/model.dart';

class MoviesPopularResponse {
    MoviesPopularResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    final int page;
    final List<Movie> results;
    final int totalPages;
    final int totalResults;

    factory MoviesPopularResponse.fromJson(String str) => MoviesPopularResponse.fromMap(json.decode(str));

    factory MoviesPopularResponse.fromMap(Map<String, dynamic> json) => MoviesPopularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}