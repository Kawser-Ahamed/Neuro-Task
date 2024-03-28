import 'dart:convert';
import 'dart:io';

import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:neuro_task/constant/responsive.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  
  String text = 'empty';
  Future <void> getText() async{
    String apiKey = "0a8bc449c65e40b5b9e4cbfd553ba7dd56ae805f";

    Deepgram deepgram = Deepgram(apiKey);

    File audioFile = File('/storage/emulated/0/Android/data/com.example.neuro_task/files/recording.aac');
    
    String json  = await deepgram.transcribeFromFile(audioFile);
    Map<String, dynamic> data = jsonDecode(json);
    text = data['results']['channels'][0]['alternatives'][0]['transcript'];
  }
  @override
  Widget build(BuildContext context) {
    double height = Responsive.screenHeight(context);
    double width = Responsive.screenWidth(context);
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text),
            ElevatedButton(
              onPressed: (){
                getText().whenComplete((){
                  setState(() {});
                });
              }, 
              child: const Text('press me'),
            ),
          ],
        ),
      ),
    );
  }
}