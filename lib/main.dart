import 'package:flutter/material.dart';
import 'package:projeto2anos/pages/main_page.dart';
import 'package:projeto2anos/pages/primeiros_passos.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
