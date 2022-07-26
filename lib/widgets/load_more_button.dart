import 'package:best_movies_ever/providers/grid_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _moviesProvider = Provider.of<Movies>(context, listen: true);
    var _gridItemsProvider = Provider.of<GridItems>(context, listen: true);
    int activePage = _moviesProvider.pageNum;
    int totalPages = _moviesProvider.totalPages;
    return Visibility(
      visible: _gridItemsProvider.moreButtonOn,
      child: FloatingActionButton(
          tooltip: 'Load More',
          onPressed: activePage == totalPages
              ? null
              : () {
                  if (activePage < totalPages) {
                    activePage = activePage + 1;
                    Provider.of<Movies>(context, listen: false)
                        .updatePageNum(activePage);
                    print(activePage);
                  }
                },
          // child: Icon(Icons.more_horiz));
          child: Text('More')),
    );
  }
}
