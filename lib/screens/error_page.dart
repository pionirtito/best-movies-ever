import 'package:flutter/material.dart';
import '../configs/constants.dart';

class ErrorPageScreen extends StatelessWidget {
  final String title;
  final String message;
  final bool justPop;
  const ErrorPageScreen(
      {this.title = 'Error',
      this.message = 'Something went wrong',
      this.justPop = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorError,
        leading: justPop
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded))
            : IconButton(
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/');
                  Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
                },
                icon: const Icon(Icons.home_rounded)),
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
