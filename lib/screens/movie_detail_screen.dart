import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../configs/routes_generator.dart';
import '../widgets/movie_details_view.dart';
import '../widgets/movies_grid_view.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieDetailScreen({Key? key}) : super(key: key);
  // static String routeName = '/movie?id='; //INFO: Moze da se napravi dinamicka ruta ali da ne komplikujemo
  static String routeName = '/movie-details';
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  String argId = '?';
  String argTitle = 'Movie details';
  var list;

  @override
  initState() {
    print('1️⃣ initState from Movie Detail page screen');

    super.initState();
  }

  @override
  didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    argId = arguments['argId'].toString();
    argTitle = arguments['argTitle'];
    print('⚙⚙⚙⚙');
    print(argId);
    Provider.of<Movies>(context).getMovieByID(argId).then((_) {
      setState(() {
        _isLoading = false;
        _isInit = false;
      });
    }).catchError((e) {
      print(e);
      Navigator.pushReplacement(
          context,
          RouteGenerator.errorOnPage('Error: ${e.status}', e.message,
              justPop: false));
    });

    // setState(() {
    //   _isLoading = Provider.of<Movies>(context, listen: true).isLoading;
    // });
    // }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(argTitle),
      ),
      body: Container(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MovieDetailsView(),
        // child: Text('v'),
      ),
    );
  }
}
