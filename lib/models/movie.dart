import 'package:flutter/cupertino.dart';

class Movie with ChangeNotifier {
  final int id;
  final String title;
  final String overview;
  final String? voteAverage;
  final String? voteCount;
  final String? popularity;
  final String? backdropPath;
  final String? posterPath;
  final int? runtime;
  final List? genres;
  final String? shareLink;

  Movie(
      {required this.id,
      required this.title,
      this.overview = 'N/A',
      this.voteAverage,
      this.voteCount,
      this.popularity,
      this.backdropPath,
      this.posterPath,
      this.runtime,
      this.genres,
      this.shareLink});
}
