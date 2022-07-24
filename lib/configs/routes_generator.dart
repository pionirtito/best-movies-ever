import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/screens/error_page.dart';
import 'package:best_movies_ever/screens/movie_detail_screen.dart';
import 'package:best_movies_ever/screens/movies_page_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // home
    if (settings.name == MoviesPageScreen.routeName) {
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const MoviesPageScreen());
    }

    // detail
    else if (settings.name == MovieDetailScreen.routeName) {
      if (settings.arguments == null) {
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const MoviesPageScreen());
      }

      print('ZZZZZZZZZZZZZZZZ');
      print(settings.arguments);
      return PageRouteBuilder(
          settings: settings, pageBuilder: (_, __, ___) => MovieDetailScreen());
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
