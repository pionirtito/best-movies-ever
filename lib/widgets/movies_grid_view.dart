import 'dart:ui';

import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/movies_provider.dart';

class MoviesGridView extends StatelessWidget {
  const MoviesGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Movie> providedList = Provider.of<Movies>(context).moviesList;
    Provider.of<Movies>(context).moviesList;
    return Center(
      child: Container(
        padding: MediaQuery.of(context).size.width < kSsWidth
            ? EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0)
            : EdgeInsets.all(24.0),
        width: MediaQuery.of(context).size.width < kSsWidth ? null : 500,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.5,
            ),
            itemCount: providedList.length,
            itemBuilder: (BuildContext context, int index) {
              var listItem = providedList[index];
              return Container(
                padding: EdgeInsets.all(4.0),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  key: Key('${providedList[index].id}'),
                  // color: Colors.amber,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w300/${listItem.backdropPath}'),
                          fit: BoxFit.cover,
                          colorFilter:
                              ColorFilter.mode(Colors.white70, BlendMode.hue)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 0.0),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            style: TextButton.styleFrom(
                              elevation: 5,
                              // backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              backgroundColor: kColorOrange,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 12.0),
                              // primary: Colors.white,

                              textStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width <
                                          kSsWidth
                                      ? 12
                                      : 16,
                                  fontWeight: FontWeight.normal),
                            ),
                            // onHover: (v) {},
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                MovieDetailScreen.routeName,
                                arguments: <String, dynamic>{
                                  'action': 'details',
                                  'argId': listItem.id,
                                  'argTitle': listItem.title
                                },
                              );
                            },
                            child: Text(
                              '${listItem.title}',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
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
                                '${listItem.popularity}',
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
                  // child: Column(children: [
                  //   Container(
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: NetworkImage(
                  //             'https://image.tmdb.org/t/p/w300/${Provider.of<Movies>(context).moviesList[index].posterPath}'),
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //     child: Text('yo') /* add child content here */,
                  //   ),

                  //   // ListTile(
                  //   //   // leading: Icon(Icons.arrow_drop_down_circle),
                  //   //   title: Text(
                  //   //       '${Provider.of<Movies>(context).moviesList[index].title}'),
                  //   //   subtitle: Text(
                  //   //     'Popularity: ${Provider.of<Movies>(context).moviesList[index].popularity}',
                  //   //     style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  //   //   ),
                  //   // ),
                  // ],

                  // ),
                ),
              );
            }),
      ),
    );
  }
}
