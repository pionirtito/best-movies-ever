import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class Paginator extends StatelessWidget {
  const Paginator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int activePage = Provider.of<Movies>(context, listen: true).pageNum;
    int totalPages = Provider.of<Movies>(context, listen: true).totalPages;
    return Container(
      width: 100,
      color: Colors.amber,
      child: Row(
        children: [
          IconButton(
              onPressed: activePage == 1
                  ? null
                  : () {
                      if (activePage > 1) {
                        activePage = activePage - 1;
                        Provider.of<Movies>(context, listen: false)
                            .updatePageNum(activePage);
                        print(activePage);
                      }
                    },
              icon: Icon(Icons.skip_previous_rounded)),
          IconButton(
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
              icon: Icon(Icons.skip_next_rounded))
        ],
      ),
    );
  }
}
