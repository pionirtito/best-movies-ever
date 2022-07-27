import 'package:flutter/material.dart';

import '../configs/constants.dart';
import '../models/movie.dart';
import '../screens/movie_detail_screen.dart';

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
    colorFilter = const ColorFilter.mode(Colors.white70, BlendMode.hue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('${widget.listItem.id}'),
      padding: MediaQuery.of(context).size.width < kSsWidth
          ? const EdgeInsets.all(0.0)
          : const EdgeInsets.all(4.0),
      child: MouseRegion(
        onEnter: ((event) {
          setState(() {
            colorFilter = null;
          });
        }),
        onExit: ((event) {
          setState(() {
            colorFilter = const ColorFilter.mode(Colors.white70, BlendMode.hue);
          });
        }),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '${MovieDetailScreen.routeNameByIDquery}${widget.listItem.id}',
              arguments: <String, dynamic>{
                'action': 'details',
                'argId': widget.listItem.id,
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
                children: [
                  Container(
                    height: 96,
                    width: double.infinity,
                    color: Colors.black54,
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        widget.listItem.title,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            letterSpacing: kLetterSpacing,
                            fontSize:
                                MediaQuery.of(context).size.width < kSsWidth
                                    ? 12
                                    : 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 32,
                    color: Colors.black54,
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: kColorOrange,
                        ),
                        Text(
                          '${widget.listItem.popularity}',
                          style: TextStyle(
                            letterSpacing: kLetterSpacing,
                            fontSize:
                                MediaQuery.of(context).size.width < kSsWidth
                                    ? 12
                                    : 16,
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
