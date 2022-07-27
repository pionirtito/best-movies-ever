import 'package:best_movies_ever/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/movies_provider.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Movie movie = Provider.of<Movies>(context).activeMovie;
    var genres = movie.genres;
    List<String> genresList = [];
    for (var element in genres!) {
      genresList.add(element['name']);
    }

    String genreText = genresList.toString();
    genreText = genreText.substring(1, genreText.length - 1);

    return Center(
        child: Container(
      padding: MediaQuery.of(context).size.width < kSsWidth
          ? const EdgeInsets.all(4.0)
          : const EdgeInsets.all(32.0),
      width: MediaQuery.of(context).size.width < kSsWidth ? null : 500,
      child: ListView(
        shrinkWrap: true,
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              movie.posterPath.toString(),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.title,
                color: Colors.black,
              ),
              title: Text(movie.title),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.theater_comedy,
                color: Colors.black,
              ),
              title: Text(genreText),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.watch_later_outlined,
                color: Colors.teal,
              ),
              title: Text('${movie.runtime} minutes'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.star,
                color: kColorOrange,
              ),
              title: Text(movie.voteAverage.toString()),
              subtitle: Text('${movie.voteCount} votes'),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: ListTile(
                leading: const Icon(
                  Icons.description,
                  color: Colors.black,
                ),
                title: Text(movie.overview),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
