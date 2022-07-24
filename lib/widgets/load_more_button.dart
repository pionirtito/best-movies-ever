import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int activePage = Provider.of<Movies>(context, listen: true).pageNum;
    int totalPages = Provider.of<Movies>(context, listen: true).totalPages;
    return FloatingActionButton(
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
        child: Text('More'));
  }
}
