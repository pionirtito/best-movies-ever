import 'package:best_movies_ever/providers/grid_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var moviesProvider = Provider.of<Movies>(context, listen: true);
    var gridItemsProvider = Provider.of<GridItems>(context, listen: true);
    int activePage = moviesProvider.pageNum;
    int totalPages = moviesProvider.totalPages;
    return AnimatedOpacity(
      opacity: gridItemsProvider.moreButtonOn ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: Visibility(
        visible: gridItemsProvider.moreButtonOn,
        child: FloatingActionButton(
            tooltip: 'Load More Movies',
            onPressed: activePage == totalPages
                ? null
                : () {
                    if (activePage < totalPages) {
                      activePage = activePage + 1;
                      Provider.of<Movies>(context, listen: false)
                          .updatePageNum(activePage);
                    }
                  },
            child: const Text('More')),
      ),
    );
  }
}
