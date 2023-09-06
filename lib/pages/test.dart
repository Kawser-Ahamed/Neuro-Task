// import 'package:flutter/material.dart';

// class Circle2 extends StatefulWidget {
//   const Circle2({Key? key}) : super(key: key);

//   @override
//   State<Circle2> createState() => _Circle2State();
// }

// class _Circle2State extends State<Circle2> {
//    List<Path> _paths = []; // Store multiple paths
//   Path _currentPath = Path(); // Store the current path

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onPanStart: (details) {
//           setState(() {
//             _currentPath = Path();
//             _currentPath.moveTo(details.localPosition.dx, details.localPosition.dy);
//           });
//         },
//         onPanUpdate: (details) {
//           setState(() {
//             _currentPath.lineTo(details.localPosition.dx, details.localPosition.dy);
//           });
//         },
//         onPanEnd: (_) {
//           setState(() {
//             _paths.add(_currentPath);
//           });
//         },
//         child: CustomPaint(
//           painter: MyCustomPainter(paths: _paths),
//           child: Container(),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _paths.clear();
//           });
//         },
//         child: Icon(Icons.clear),
//       ),
//     );
//   }
// }

// class MyCustomPainter extends CustomPainter {
//   final List<Path> paths;

//   MyCustomPainter({required this.paths});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 4.0
//       ..strokeCap = StrokeCap.round;

//     for (final path in paths) {
//       canvas.drawPath(path, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }