import 'dart:convert';

import 'package:best_movies_ever/models/response_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../configs/constants.dart';
import '../models/movie.dart';

/* 

Napravi te aplikaciju koja prikazuje popularne filmove uz pomoc API-a https://www.themoviedb.org/ koristeci kolekciju, gde u jednom redu ima 3 filma. 

Takodje, nakon klika na odredjeni film, potrebno je prikazati detalje tog filma kao sto su ime, deskripcija, slika, ocena i trajanje filma.

 */

class Movies with ChangeNotifier {
  bool isLoading = true;
  bool moreButtonOn = false; // ?
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
    print('💚 getMovies url: $url');

    // try {
    final responseJSON = await http.get(uri);
    final Map body = jsonDecode(responseJSON.body);
    int status = responseJSON.statusCode;
    String message = body['status_message'] ?? kErrorDeafultMSG;

    ResponseMessage resMsg = ResponseMessage(status: status, reason: message);

    if (status != 200) {
      print('💔💔💔💔');
      print(resMsg.message);
      print('💔💔💔💔');
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
    // final Map<dynamic, dynamic> extractedData = testData.asMap();
    isLoading = false;
    // notifyListeners();

    print(status);
    print(message);
    // } catch (e) {
    //   pageNum = 1;
    //   moviesList.clear();
    //   print('⛔⛔ ${e}');
    //   throw (e);
    // }
  }

  Future<void> getMovieByID(String id) async {
    List resultsList;
    Movie movie;

    final urlById = '$kUrlMovie$id$kUrlSetKey${_apiKey}$kUrlLang';
    final uri = Uri.parse(urlById);
    print('💚 getMovie Id:$id Detail');
    print(urlById);

    // try {
    final responseJSON = await http.get(uri);
    final Map body = jsonDecode(responseJSON.body);

    var status = responseJSON.statusCode;
    String message = body['status_message'] ?? kErrorDeafultMSG;

    ResponseMessage resMsg = ResponseMessage(status: status, reason: message);

    if (status != 200) {
      print('😱😱😱😱');
      print(body);
      print('😱😱😱😱');
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

    print('💚💚');
    print(movie.runtime);

    // final Map<dynamic, dynamic> extractedData = testData.asMap();
    activeMovie = movie;
    isLoading = false;
    // notifyListeners();
    // } catch (e) {
    //   pageNum = 1;
    //   moviesList.clear();
    //   isLoading = true;

    //   print('⛔ ${e.toString()}');
    //   throw (e);
    // }
  }

  updatePageNum(int value) {
    pageNum = value;
    url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$pageNum&with_watch_monetization_types=flatrate';
    // isLoading = true;
    notifyListeners();
    print('page updater');
  }

  updateLoading(bool val) {
    isLoading = val;
    // notifyListeners();
  }

  clearMoviesList() {
    moviesList.clear();
    // notifyListeners();
  }

  updateMoreButton(bool val) {
    moreButtonOn = val;
    notifyListeners();
  }
}
