// To parse this JSON data, do
//
//     final movieSearchResponse = movieSearchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:movies/model/model.dart';

class MovieSearchResponse {
    MovieSearchResponse({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    final int? page;
    final List<Movie>? results;
    final int? totalPages;
    final int? totalResults;

    factory MovieSearchResponse.fromJson(String str) => MovieSearchResponse.fromMap(json.decode(str));

    factory MovieSearchResponse.fromMap(Map<String, dynamic> json) => MovieSearchResponse(
        page: (json["page"] == null) ? null : json["page"],
        results: (json["results"] == null ) ? [] : List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: (json["total_pages"] == null) ? null : json["total_pages"] ,
        totalResults: (json["total_results"] == null) ? null : json["total_results"],
    );

}