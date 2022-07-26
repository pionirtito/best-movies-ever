import 'dart:ui';

import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/providers/grid_items_provider.dart';
import 'package:best_movies_ever/screens/movie_detail_screen.dart';
import 'package:best_movies_ever/widgets/movie_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/movies_provider.dart';

class MoviesGridView extends StatefulWidget {
  const MoviesGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<MoviesGridView> createState() => _MoviesGridViewState();
}

class _MoviesGridViewState extends State<MoviesGridView> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      var _gridProvider = Provider.of<GridItems>(context, listen: false);
      var _moviesProvider = Provider.of<Movies>(context, listen: false);
      if ((_scrollController.position.maxScrollExtent - 100) <
          _scrollController.position.pixels) {
        if (_moviesProvider.pageNum < _moviesProvider.totalPages) {
          _gridProvider.updateMoreButton(true);
        }
      } else {
        _gridProvider.updateMoreButton(false);
      }
      ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int imageWidth = 500;
    List<Movie> providedList = Provider.of<Movies>(context).moviesList;
    return Center(
      child: Container(
        padding: MediaQuery.of(context).size.width < kSsWidth
            ? EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0)
            : EdgeInsets.all(24.0),
        width: MediaQuery.of(context).size.width < kSsWidth
            ? null
            : MediaQuery.of(context).size.width < klsWidth
                ? 800
                : 800,
        child: GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.5,
            ),
            itemCount: providedList.length,
            itemBuilder: (BuildContext context, int index) {
              // print(gridScrollCtrl.position.atEdge);
              var listItem = providedList[index];
              return MovieGridItem(
                  listItem: listItem,
                  providedList: providedList,
                  imageWidth: imageWidth);
            }),
      ),
    );
  }
}
