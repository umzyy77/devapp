import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/MapModel.dart';
import 'viewmodels/GameViewModel.dart';
import 'view/GameView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameViewModel(MapModel(10, 10, 15)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Démineur',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const GameView(),
      ),
    );
  }
}
