import 'package:best_movies_ever/providers/movies_provider.dart';
import 'package:best_movies_ever/widgets/load_more_button.dart';
import 'package:best_movies_ever/widgets/paginator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  var list;

  @override
  initState() {
    print('1️⃣ initState from Movies page screen');
    super.initState();
  }

  @override
  didChangeDependencies() {
    var theme = Theme.of(context);
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
      print(e.runtimeType);
      print(e.status);
      print(e.message);
      Navigator.pushReplacement(context,
          RouteGenerator.errorOnPage('Error: ${e.status}', '${e.message}'));

      Provider.of<Movies>(context, listen: false).updatePageNum(1);
      Provider.of<Movies>(context, listen: false).clearMoviesList();
      // setState(() {
      //   _isLoading = true;
      //   _isInit = true;
      // });
      // Provider.of<Movies>(context, listen: false).updateLoading(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: theme.errorColor,
          content: Text('e'),
        ),
      );
    });

    setState(() {
      print('XXXXXXXXXXXXXXXXX');
      _isLoading = Provider.of<Movies>(context, listen: true).isLoading;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var x = Provider.of<Movies>(context, listen: true).pageNum;
    return Scaffold(
      // floatingActionButton: _isLoading ? null : Paginator(),
      floatingActionButton: _isLoading ? null : LoadMoreButton(),

      appBar: AppBar(
        title: Text('Welcome to the Popular Movies'),
      ),
      body: Container(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MoviesGridView(),
        // child: Text('v'),
      ),
    );
  }
}
