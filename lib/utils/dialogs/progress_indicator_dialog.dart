import 'package:flutter/material.dart';

class ShowLoadingDialog {
  static late BuildContext passedContext;

  static void show(BuildContext context) {
    passedContext = context;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Loading..'),
                ],
              ),
            ));

    Future.delayed(Duration(seconds: 3));
  }

  static void dismiss() {
    Navigator.of(passedContext).pop();
  }
}
