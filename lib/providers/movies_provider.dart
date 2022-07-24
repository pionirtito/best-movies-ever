import 'dart:convert';

import 'package:best_movies_ever/models/response_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

/* 

Napravi te aplikaciju koja prikazuje popularne filmove uz pomoc API-a https://www.themoviedb.org/ koristeci kolekciju, gde u jednom redu ima 3 filma. 

Takodje, nakon klika na odredjeni film, potrebno je prikazati detalje tog filma kao sto su ime, deskripcija, slika, ocena i trajanje filma.

 */

class Movies with ChangeNotifier {
  bool isLoading = true;
  int pageNum = 1;
  List _resultsList = [];
  String activeId = '';
  late List<Movie> moviesList = [];
  late int totalPages;
  late int totalResults = 1;
  late String url =
      'https://api.themoviedb.org/3/discover/movie?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$pageNum&with_watch_monetization_types=flatrate';

  late Movie activeMovie;

  static const String _apiKey = '19183c673c06f7774df71e7d448c027b';
  Future<void> getMovies() async {
    final uri = Uri.parse(url);
    print('💚 getMovies url: $url');

    // final url = Uri.parse(
    //     'https://api.themoviedb.org/3/discover/movie?api_key=$_apiKey&language=en-US&sort_by=popularity.desc');

    // /discover/movie?sort_by=popularity.desc

    try {
      final responseJSON = await http.get(uri);
      var status = responseJSON.statusCode;
      var message = responseJSON.reasonPhrase;

      ResponseMessage resMsg =
          ResponseMessage(status: status, message: message);

      if (status != 200) {
        pageNum = 1;
        moviesList.clear();
        print(resMsg);
        throw (resMsg);
      }

      final Map body = jsonDecode(responseJSON.body);

      totalPages = body['total_pages'];
      totalResults = body['total_results'];
      _resultsList = body['results'];
      _resultsList.forEach((element) {
        moviesList.add(Movie(
          id: element['id'],
          title: element['title'],
          // overview: element['overview'],
          // voteAverage: element['vote_average'],
          // voteCount: element['vote_count'],
          backdropPath: element['poster_path'],
          popularity: '${element['popularity'].toStringAsFixed(1)}',
        ));
      });
      // final Map<dynamic, dynamic> extractedData = testData.asMap();
      // updateMoviesList(moviesList);
      isLoading = false;
      // notifyListeners();

      print(status);
    } catch (e) {
      pageNum = 1;
      moviesList.clear();
      print('⛔ $e');
      throw (e);
    }
  }

  Future<void> getMovieByID(String id) async {
    List resultsList;
    Movie movie;
    final urlById =
        'https://api.themoviedb.org/3/movie/$id?api_key=${_apiKey}&language=en-US';
    final uri = Uri.parse(urlById);
    print('💚 getMovie Id:$id Detail');
    print(urlById);

    // final url = Uri.parse(
    //     'https://api.themoviedb.org/3/discover/movie?api_key=$_apiKey&language=en-US&sort_by=popularity.desc');

    // /discover/movie?sort_by=popularity.desc

    try {
      final responseJSON = await http.get(uri);
      final Map body = jsonDecode(responseJSON.body);

      var status = responseJSON.statusCode;
      var message = responseJSON.reasonPhrase;

      ResponseMessage resMsg =
          ResponseMessage(status: status, message: message);

      if (status != 200) {
        pageNum = 1;
        moviesList.clear();
        print(resMsg);
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
      // updateMoviesList(moviesList);
      activeMovie = movie;
      isLoading = false;
      // notifyListeners();
    } catch (e) {
      pageNum = 1;
      moviesList.clear();
      isLoading = true;

      print('⛔ $e');
      throw (e);
    }
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

  updateMoviesList(List<Movie> value) {
    moviesList = value;
    // notifyListeners();
  }
}
