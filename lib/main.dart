import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/map_page.dart';
import 'package:google_maps_yt/pages/welcomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}
