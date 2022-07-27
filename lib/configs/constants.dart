import 'package:flutter/material.dart';

// SCREEN SIZES
double kSsWidth = 500;
double klsWidth = 900;

// TEXT
String kAppTitle = 'Popular Movies Base';
double kLetterSpacing = 1.4;

// COLORS
const Color kColorDarkTeal = Color.fromARGB(255, 72, 88, 109);
const Color kColorOrange = Color.fromARGB(255, 255, 157, 0);
const Color kColorError = Color.fromARGB(255, 167, 29, 54);

// URLS
const String kUrlMovies = 'https://api.themoviedb.org/3/discover/movie';
const kUrlMovie = 'https://api.themoviedb.org/3/movie/';

const kUrlImage = 'https://image.tmdb.org/t/p/w';

const kUrlSetKey = '?api_key=';
const kUrlLang = '&language=en-US';
const kUrlPopSort = '&sort_by=popularity.desc';
const kUrlAdult = '&include_adult=false';
const kUrlVideo = '&include_video=false';
const kUrlSetPage = '&page=';
const String kUrlWatch = '&with_watch_monetization_types=flatrate';

//INFO: Movies popularity URL:'https://api.themoviedb.org/3/discover/movie?api_key={ API_KEY }&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page={ PAGE_NUMBER }&with_watch_monetization_types=flatrate'

//INFO: Movie by ID URL: 'https://api.themoviedb.org/3/movie/{ MOVIE_ID }?api_key={ API_KEY }&language=en-US'

// MESSAGES
String kErrorDeafultMSG = 'Something went wrong';
