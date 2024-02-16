// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';


// class VoiceRecorderPage extends StatefulWidget {
//   @override
//   _VoiceRecorderPageState createState() => _VoiceRecorderPageState();
// }

// class _VoiceRecorderPageState extends State<VoiceRecorderPage> {
//   final stt.SpeechToText _speechToText = stt.SpeechToText();
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   String _recognizedText = 'Empty';
//   bool _isRecording = false;
//   bool _isSpeechToTextEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     _isSpeechToTextEnabled = await _speechToText.initialize();
//     await Permission.microphone.request();
//     await Permission.storage.request();
//     await _recorder.openRecorder();
//   }

//   Future<void> _startRecording() async {
//     setState(() {
//       _isRecording = true;
//     });
//     await _recorder.startRecorder(toFile: 'test.aac', codec: Codec.aacMP4);
//   }

//   Future<void> _stopRecording() async {
//     setState(() {
//       _isRecording = false;
//     });
//     await _recorder.stopRecorder();
//     await _recognizeSpeech();
//   }

//   Future<void> _recognizeSpeech() async {
//     if (!_isSpeechToTextEnabled) {
//       print('Speech to text is not available');
//       return;
//     }

//     final stt.SpeechToText _speech = stt.SpeechToText();
//     bool available = await _speech.initialize();
//     if (available) {
//       _speech.listen(
//         onResult: (result) {
//           setState(() {
//             _recognizedText = result.recognizedWords;
//           });
//         },
//       );
//     } else {
//       print('The user has denied the use of speech recognition');
//     }
//   }

//   @override
//   void dispose() {
//     _recorder.closeRecorder();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Voice Recorder & Speech to Text'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _isRecording
//                 ? Text('Recording...')
//                 : Text('Press button to start recording'),
//             SizedBox(height: 20),
//             _isRecording
//                 ? ElevatedButton(
//                     onPressed: _stopRecording,
//                     child: Text('Stop Recording'),
//                   )
//                 : ElevatedButton(
//                     onPressed: _startRecording,
//                     child: Text('Start Recording'),
//                   ),
//             SizedBox(height: 20),
//             Text('Recognized Text:', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text(_recognizedText, style: TextStyle(fontSize: 20)),
//           ],
//         ),
//       ),
//     );
//   }
// }
