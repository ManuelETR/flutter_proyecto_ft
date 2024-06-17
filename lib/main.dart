import 'package:flutter/material.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Cascaron para proyecto FT'),),
      body: const Center(child: Text('El Martin es un Monster Hunter')),
      ),
    );
    }
    }