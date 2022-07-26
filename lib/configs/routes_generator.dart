import 'package:best_movies_ever/screens/error_page.dart';
import 'package:best_movies_ever/screens/movie_detail_screen.dart';
import 'package:best_movies_ever/screens/movies_page_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String movieIDquery = MovieDetailScreen.routeNameByIDquery;
    // home [ / ]
    if (settings.name == MoviesPageScreen.routeName) {
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const MoviesPageScreen());
    }

    // detail [ http://localhost:62269/#/movie-details?id={ MOVIE_ID } ]
    else if (settings.name!.contains(MovieDetailScreen.routeNameByIDquery)) {
      if (settings.arguments == null) {
        //INFO: MOVIE_ID from params
        var urlIDSplit = Uri.base.toString().split(movieIDquery);
        String? movieIDfromParams = urlIDSplit[1];
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => MovieDetailScreen(
                  paramID: movieIDfromParams,
                ));
      } else {
        //INFO: MOVIE_ID from grid item click
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => MovieDetailScreen());
      }
    } else {
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const ErrorPageScreen(
        title: 'Error',
        message: 'No route',
      );
    });
  }

  static Route<dynamic> errorOnPage(String title, String message,
      {bool justPop = false}) {
    return MaterialPageRoute(builder: (_) {
      return ErrorPageScreen(
        title: title,
        message: message,
        justPop: justPop,
      );
    });
  }
}
