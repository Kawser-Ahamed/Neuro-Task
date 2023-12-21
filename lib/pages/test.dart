import 'dart:io';

import 'package:device_screen_recorder/device_screen_recorder.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

bool recording = false;
  String path = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              recording
                  ? OutlinedButton(
                      onPressed: () async {
                        var file = await DeviceScreenRecorder.stopRecordScreen();
                        final firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref("Screen record/myrecord");
                         try{
                          File files = File(file.toString());
                          await storageReference.putFile(File(files.path));
                          debugPrint('submitted');
                         }
                         catch(e){
                          debugPrint(e.toString());
                         }
                        setState(() {
                          path = file ?? '';
                          recording = false;
                        });
                      },
                      child: const Text('Stop'),
                    )
                  : OutlinedButton(
                      onPressed: () async {
                        var status = await DeviceScreenRecorder.startRecordScreen();
                        // var status = await ScreenRecorder.startRecordScreen(name: 'example');
                        setState(() {
                          recording = status ?? false;
                        });
                      },
                      child: const Text('Start'),
                    ),
              Text(path)
            ],
          ),
        ),
      );
  }
}