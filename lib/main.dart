import 'package:best_movies_ever/configs/constants.dart';
import 'package:best_movies_ever/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/routes_generator.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/grid_items_provider.dart';

Future<void> main() async {
  // await dotenv.load(); // default for '.env'
  await dotenv.load(fileName: "dotenv");
  runApp(const BestMoviesApp());
}

class BestMoviesApp extends StatelessWidget {
  const BestMoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Movies>(create: (ctx) => Movies()),
        ChangeNotifierProvider<GridItems>(create: (ctx) => GridItems())
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Roboto Mono',
            errorColor: kColorError,
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.black87),
              foregroundColor: MaterialStatePropertyAll<Color>(kColorOrange),
            )),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: kColorOrange, foregroundColor: Colors.black),
            primaryColor: kColorDarkTeal,
            scaffoldBackgroundColor: Colors.blueGrey.shade100,
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: kColorOrange),
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                backgroundColor: kColorOrange,
                foregroundColor: Colors.black)),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/', // home: MoviesPageScreen(),
      ),
    );
  }
}
