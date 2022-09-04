import 'package:best_movies_ever/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../configs/routes_generator.dart';
import '../widgets/movie_details_view.dart';

class MovieDetailScreen extends StatefulWidget {
  final String? paramID;
  const MovieDetailScreen({this.paramID, Key? key}) : super(key: key);
  static String routeNameByIDquery = '/movie-details/';
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  String argId = '_';
  String argTitle = 'Movie details';

  @override
  initState() {
    super.initState();
  }

  @override
  didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    var argumentsRaw = ModalRoute.of(context)!.settings.arguments;
    if (argumentsRaw != null) {
      Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;
      argId = arguments['argId'].toString();
    } else {
      argId = widget.paramID!;
    }

    Provider.of<Movies>(context).getMovieByID(argId).then((_) {
      setState(() {
        _isLoading = false;
        _isInit = false;
      });
    }).catchError((e) {
      Navigator.pushReplacement(
          context,
          RouteGenerator.errorOnPage('Error: ${e.status}', e.message,
              justPop: false));
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ModalRoute.of(context)!.settings.arguments != null
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded))
            : IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
                },
                icon: const Icon(Icons.home_rounded)),
        title: Text(argTitle),
      ),
      body: Container(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const MovieDetailsView(),
      ),
    );
  }
}
