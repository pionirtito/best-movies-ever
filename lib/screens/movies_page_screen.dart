import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/providers/movies_provider.dart';
import 'package:best_movies_ever/widgets/load_more_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/routes_generator.dart';
import '../providers/grid_items_provider.dart';
import '../widgets/movies_grid_view.dart';

class MoviesPageScreen extends StatefulWidget {
  const MoviesPageScreen({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  State<MoviesPageScreen> createState() => _MoviesPageScreenState();
}

class _MoviesPageScreenState extends State<MoviesPageScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  initState() {
    super.initState();
  }

  @override
  didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }

    Provider.of<Movies>(context).getMovies().then((_) {
      Provider.of<GridItems>(context, listen: false).updateMoreButton(false);
      setState(() {
        _isLoading = false;
        _isInit = false;
      });
    }).catchError((e) {
      Navigator.pushReplacement(context,
          RouteGenerator.errorOnPage('Error: ${e.status}', '${e.message}'));

      Provider.of<Movies>(context, listen: false).updatePageNum(1);
      Provider.of<Movies>(context, listen: false).clearMoviesList();
    });

    setState(() {
      _isLoading = Provider.of<Movies>(context, listen: true).isLoading;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isLoading ? null : const LoadMoreButton(),
      appBar: AppBar(
        title: Text(kAppTitle),
      ),
      body: Container(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            // ignore: prefer_const_constructors
            : MoviesGridView(),
      ),
    );
  }
}
