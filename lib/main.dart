import 'package:flutter/material.dart';
import 'package:notella/views/login.dart';
import 'package:notella/views/register.dart';

void main() {
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const RegisterView(),
  )
  );
}

