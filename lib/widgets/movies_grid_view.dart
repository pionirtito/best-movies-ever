import 'dart:ui';

import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/screens/movie_detail_screen.dart';
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
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int imageWidth = 500;
    var xxx = 'open';
    List<Movie> providedList = Provider.of<Movies>(context).moviesList;
    Provider.of<Movies>(context).moviesList;
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

class MovieGridItem extends StatefulWidget {
  const MovieGridItem({
    Key? key,
    required this.listItem,
    required this.providedList,
    required this.imageWidth,
  }) : super(key: key);

  final Movie listItem;
  final List<Movie> providedList;
  final int imageWidth;

  @override
  State<MovieGridItem> createState() => _MovieGridItemState();
}

late ColorFilter? colorFilter;

class _MovieGridItemState extends State<MovieGridItem> {
  @override
  void initState() {
    colorFilter = ColorFilter.mode(Colors.white70, BlendMode.hue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('${widget.listItem.id}'),
      padding: MediaQuery.of(context).size.width < kSsWidth
          ? EdgeInsets.all(0.0)
          : EdgeInsets.all(4.0),
      child: MouseRegion(
        onEnter: ((event) {
          setState(() {
            colorFilter = null;
          });
        }),
        onExit: ((event) {
          setState(() {
            colorFilter = ColorFilter.mode(Colors.white70, BlendMode.hue);
          });
        }),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              MovieDetailScreen.routeName,
              arguments: <String, dynamic>{
                'action': 'details',
                'argId': widget.listItem.id,
                'argTitle': widget.listItem.title
              },
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            // color: Colors.amber,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        '$kUrlImage${widget.imageWidth}/${widget.listItem.backdropPath}'),
                    fit: BoxFit.cover,
                    colorFilter: colorFilter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // SizedBox(height: 0.0),
                  Container(
                    height: 96,
                    width: double.infinity,
                    color: Colors.black54,
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '${widget.listItem.title}',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // SizedBox(height: 36.0),
                  Container(
                    height: 32,
                    // width: ,
                    color: Colors.black54,
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                        Text(
                          '${widget.listItem.popularity}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
