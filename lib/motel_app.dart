import 'package:flutter/material.dart';

BuildContext? applicationcontext;

class MotelApp extends StatefulWidget {
  const MotelApp({super.key});

  @override
  MotelAppState createState() => MotelAppState();
}

class MotelAppState extends State<MotelApp> {
  @override
  Widget build(BuildContext context) {
    applicationcontext = context;

    return Container();
  }
}
