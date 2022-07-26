import 'dart:convert';

import 'package:best_movies_ever/models/response_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../configs/constants.dart';
import '../models/movie.dart';

class GridItems with ChangeNotifier {
  bool moreButtonOn = false;

  updateMoreButton(bool val) {
    moreButtonOn = val;
    notifyListeners();
  }
}
