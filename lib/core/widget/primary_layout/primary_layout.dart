import 'package:flutter/material.dart';

class PrimaryLayout extends StatelessWidget{

  final  Widget child;

  const PrimaryLayout({super.key,required this.child});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Insight"),
      ),
      body: child,

    );

  }

 }
