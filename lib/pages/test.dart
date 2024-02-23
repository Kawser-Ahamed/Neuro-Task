import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  showGeneralDialog(
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                    context: context, 
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.52,
                            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03),
                            color: Colors.blue,
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: 50,
                  width: 200,
                  color: Colors.red,
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}