import 'dart:convert';

import 'package:best_movies_ever/models/response_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../configs/constants.dart';
import '../models/movie.dart';

class Movies with ChangeNotifier {
  bool isLoading = true;
  bool moreButtonOn = false;
  var gridScrollCtrl = ScrollController();

  static final String _apiKey =
      dotenv.get('API_KEY', fallback: 'API_KEY not found');

  int pageNum = 1;
  List _resultsList = [];
  String activeId = '';
  late List<Movie> moviesList = [];
  late int totalPages;
  late int totalResults = 1;

  late String url =
      '$kUrlMovies$kUrlSetKey$_apiKey$kUrlPopSort$kUrlAdult$kUrlLang$kUrlVideo$kUrlSetPage$pageNum$kUrlWatch';

  late Movie activeMovie;

  Future<void> getMovies() async {
    final uri = Uri.parse(url);
    final responseJSON = await http.get(uri);
    final Map body = jsonDecode(responseJSON.body);
    int status = responseJSON.statusCode;
    String message = body['status_message'] ?? kErrorDeafultMSG;

    ResponseMessage resMsg = ResponseMessage(status: status, reason: message);

    if (status != 200) {
      throw (resMsg);
    }

    totalPages = body['total_pages'];
    totalResults = body['total_results'];
    _resultsList = body['results'];
    _resultsList.forEach((element) {
      moviesList.add(Movie(
        id: element['id'],
        title: element['title'],
        backdropPath: element['backdrop_path'],
        popularity: '${element['popularity'].toStringAsFixed(1)}',
      ));
    });
    isLoading = false;
  }

  Future<void> getMovieByID(String id) async {
    Movie movie;

    final urlById = '$kUrlMovie$id$kUrlSetKey$_apiKey$kUrlLang';
    final uri = Uri.parse(urlById);

    final responseJSON = await http.get(uri);
    final Map body = jsonDecode(responseJSON.body);

    var status = responseJSON.statusCode;
    String message = body['status_message'] ?? kErrorDeafultMSG;

    ResponseMessage resMsg = ResponseMessage(status: status, reason: message);

    if (status != 200) {
      throw (resMsg);
    }

    movie = Movie(
        id: body['id'],
        title: body['title'],
        overview: body['overview'],
        runtime: body['runtime'],
        posterPath: 'https://image.tmdb.org/t/p/w500/${body['poster_path']}',
        voteAverage: '${body['vote_average'].toStringAsFixed(1)}',
        voteCount: body['vote_count'].toString(),
        genres: body['genres']);

    activeMovie = movie;
    isLoading = false;
  }

  updatePageNum(int value) {
    pageNum = value;
    url =
        '$kUrlMovies$kUrlSetKey$_apiKey$kUrlPopSort$kUrlAdult$kUrlLang$kUrlVideo$kUrlSetPage$pageNum$kUrlWatch';
    notifyListeners();
  }

  updateLoading(bool val) {
    isLoading = val;
  }

  clearMoviesList() {
    moviesList.clear();
  }

  updateMoreButton(bool val) {
    moreButtonOn = val;
    notifyListeners();
  }
}
