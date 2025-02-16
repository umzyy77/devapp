import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/GameViewModel.dart';
import 'models/MapModel.dart';
import 'view/HomeView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Démineur',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
