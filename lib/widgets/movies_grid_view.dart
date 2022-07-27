import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/providers/grid_items_provider.dart';
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
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      var gridProvider = Provider.of<GridItems>(context, listen: false);
      var moviesProvider = Provider.of<Movies>(context, listen: false);
      if ((_scrollController.position.maxScrollExtent - 100) <
          _scrollController.position.pixels) {
        if (moviesProvider.pageNum < moviesProvider.totalPages) {
          gridProvider.updateMoreButton(true);
        }
      } else {
        gridProvider.updateMoreButton(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int imageWidth = MediaQuery.of(context).size.width < kSsWidth ? 200 : 500;
    List<Movie> providedList = Provider.of<Movies>(context).moviesList;
    return Center(
      child: Container(
        padding: MediaQuery.of(context).size.width < kSsWidth
            ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0)
            : const EdgeInsets.all(24.0),
        width: MediaQuery.of(context).size.width < kSsWidth
            ? null
            : MediaQuery.of(context).size.width < klsWidth
                ? klsWidth
                : klsWidth,
        child: GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.5,
            ),
            itemCount: providedList.length,
            itemBuilder: (BuildContext context, int index) {
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
