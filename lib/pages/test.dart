
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:screenshot/screenshot.dart';

// class ScreenshotWidget extends StatefulWidget {
//   @override
//   _ScreenshotWidgetState createState() => _ScreenshotWidgetState();
// }

// class _ScreenshotWidgetState extends State<ScreenshotWidget> {
//   final _screenshotController = ScreenshotController();
//   Uint8List? _capturedImageBytes;


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.maxFinite.h,
//       width: double.maxFinite.w,
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Screenshot(
//             controller: _screenshotController,
//             child: Container(
//               color: Colors.blue, // Your page content here
//               child: const Center(
//                 child: Text(
//                   '',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _captureScreenshot,
//             child: Text('Capture Screenshot'),
//           ),
//           SizedBox(height: 20),
//           if (_capturedImageBytes != null)
//             Image.memory(
//               _capturedImageBytes!,
//               width: 200,
//               height: 200,
//             ),
//         ],
//       ),
//     );
//   }

//   void _captureScreenshot() async {
//     final imageBytes = await _screenshotController.capture();
//     setState(() {
//       _capturedImageBytes = imageBytes;
//     });
//   }
// }
