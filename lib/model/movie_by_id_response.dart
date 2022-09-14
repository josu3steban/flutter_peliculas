// To parse this JSON data, do
//
//     final movieByIdResponse = movieByIdResponseFromMap(jsonString);

import 'dart:convert';

import 'model.dart';

class MovieByIdResponse {
    MovieByIdResponse({
        required this.id,
        required this.cast,
    });

    final int id;
    final List<Cast> cast;

    factory MovieByIdResponse.fromJson(String str) => MovieByIdResponse.fromMap(json.decode(str));

    factory MovieByIdResponse.fromMap(Map<String, dynamic> json) => MovieByIdResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    );

}


