import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/providers/movies_provider.dart';
import 'package:best_movies_ever/screens/movies_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/routes_generator.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "dotenv");
  // await dotenv.load();
  runApp(const BestMoviesApp());
}

class BestMoviesApp extends StatelessWidget {
  const BestMoviesApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'The Best Movies Ever',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: MoviesHomePageScreen(),
    // );
    return MultiProvider(
      providers: [ChangeNotifierProvider<Movies>(create: (ctx) => Movies())],
      child: MaterialApp(
        theme: ThemeData(
            errorColor: kColorError,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.black, foregroundColor: kColorOrange),
            primaryColor: kColorTeal,
            scaffoldBackgroundColor: Colors.blueGrey.shade100,
            progressIndicatorTheme:
                ProgressIndicatorThemeData(color: kColorOrange),
            appBarTheme: AppBarTheme(
                centerTitle: true,
                backgroundColor: kColorOrange,
                foregroundColor: Colors.black)),
        // home: MoviesPageScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}

//API: https://api.themoviedb.org/3/movie/550?api_key=19183c673c06f7774df71e7d448c027b