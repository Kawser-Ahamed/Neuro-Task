import 'dart:math';

import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  const MyContainer({super.key});

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  final Random random = Random();
  double x=0.1,y=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            InkWell(
              onTap: (){
                x = (0.1+ random.nextDouble() * (0.8 - 0.1));
                y = (0 + random.nextDouble() * (0.8 - 0));
                setState(() {
                  
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height * 0.1,
                color: Colors.red,
                margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width * y),top: MediaQuery.of(context).size.height * x),
              ),
            ),
          ],
        )
      ),
    );
  }
}