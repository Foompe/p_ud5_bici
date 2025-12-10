import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("AppBar"),
        centerTitle: true,
      ),

      body: Container(
        color: Colors.lightGreenAccent,
        alignment: Alignment.center,
        child: Text("Body")
      ),

      bottomNavigationBar: Container(
        height: 100,
        color: Colors.redAccent,
        alignment: Alignment.center,
        child: const Text("BottomBar"),
      ),
    );
  }
}

