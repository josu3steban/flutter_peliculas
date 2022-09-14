// To parse this JSON data, do
//
//     final moviesResponde = moviesRespondeFromMap(jsonString);

import 'dart:convert';

import 'package:movies/model/model.dart';

class MovieResponse {
    MovieResponse({
        // this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    // final Dates? dates;
    final int page;
    final List<Movie> results;
    final int totalPages;
    final int totalResults;

    factory MovieResponse.fromJson(String str) => MovieResponse.fromMap(json.decode(str));

    factory MovieResponse.fromMap(Map<String, dynamic> json) => MovieResponse(
        // dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}

class Dates {
    Dates({
        this.maximum,
        this.minimum,
    });

    final DateTime? maximum;
    final DateTime? minimum;

    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

}

