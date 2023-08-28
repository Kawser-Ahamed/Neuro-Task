// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';


// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {

//   int start = 0,end=0;
//   List<Offset> _points = [];
//   bool isDrawingInsideBox = false;
//   bool isEndingInsideBox = false;
//   final CirclePainter _painter = CirclePainter();
//   bool _isDrawingInside = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.maxFinite,
//         width: double.maxFinite,
//         color: Colors.white,
//         child: GestureDetector(
//           onPanStart: (details) {
//             setState(() {
//               isDrawingInsideBox = screenBox(details.localPosition);
//               isEndingInsideBox = true; // Reset the end status when drawing starts
//               _points.add(details.localPosition); // Add the starting point
//             });
//           },
//           onPanUpdate: (DragUpdateDetails details) {
//             setState(() {
//               _points.add(details.localPosition);
//             });
//           },
//           onPanEnd: (_) {
//             if (_points.isNotEmpty) {
//               setState(() {
//                 isEndingInsideBox = screenBox(_points.last);
//               });

//               showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   title: const Text('Drawing Status'),
//                   content: Text(
//                     'Start: ${isDrawingInsideBox ? "Inside" : "Outside"}\n'
//                     'End: ${isEndingInsideBox ? "Inside" : "Outside"}',
//                   ),
//                   actions: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         setState(() {
//                           _points.clear();
//                         });
//                       },
//                       child: const Text('OK'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//           child: Container(
//             color: Colors.white,
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: (MediaQuery.of(context).size.height - 1400.h) / 2,
//                   left: (MediaQuery.of(context).size.width - 900.w) / 2,
//                   width: 900.w,
//                   height: 1400.h,
//                   child: GestureDetector(
//                     onPanStart: (_){
//                       setState(() {
//                         start = end;
//                         CirclePainter.index = start;
//                       });
//                     },
//                     onPanUpdate: (details) {
//                       setState(() {
//                         end++;
//                         _painter.addPoint(details.localPosition);
//                         if (details.localPosition.dx < 0 ||
//                             details.localPosition.dx > 900.h ||
//                             details.localPosition.dy < 0 ||
//                             details.localPosition.dy > 1400.w) {
//                           _isDrawingInside = false;
//                         }
//                       });
//                     },
//                     onPanEnd: (details) {
//                       final accuracy = calculateAccuracy(_painter);
//                           //print('end in box');
//                           showDialog(
//                             context: context,
//                             builder: (_) => AlertDialog(
//                               title: const Text('Accuracy'),
//                               content: Text('${accuracy.toStringAsFixed(2)}%'),
//                               actions: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     setState(() {
//                                       // _painter.reset();
//                                     });
//                                   },
//                                   child: const Text('OK'),
//                                 ),
//                               ],
//                             ),
//                           );
//                       setState(() {
//                         if (_isDrawingInside) {
//                           print('End inside box');
//                         } else {
//                           print('End outside box');
//                         }
//                         _isDrawingInside = true;
//                       });
//                     },
//                     child: Container(
//                       color: Colors.red,
//                       alignment: Alignment.center,
//                       child: CustomPaint(
//                         size: Size(900.w, 1400.h),
//                         painter: _painter,
//                       ),
//                     ),
//                   ),
//                 ),
//                 CustomPaint(
//                   painter: MyCustomPainter(points: _points),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   bool screenBox(Offset point) {
//     final boxCenter = Offset(MediaQuery.of(context).size.width / 2,
//         MediaQuery.of(context).size.height / 2); // Center of the red box
//     final boxWidth = 900.w; // Width of the red box
//     final boxHeight = 1400.h; // Height of the red box

//     final leftBoundary = boxCenter.dx - boxWidth / 2;
//     final rightBoundary = boxCenter.dx + boxWidth / 2;
//     final topBoundary = boxCenter.dy - boxHeight / 2;
//     final bottomBoundary = boxCenter.dy + boxHeight / 2;

//     return point.dx >= leftBoundary &&
//         point.dx <= rightBoundary &&
//         point.dy >= topBoundary &&
//         point.dy <= bottomBoundary;
//   }

//   double calculateAccuracy(CirclePainter painter) {
//     final center = Offset(900.w/2, 1400.h/2); // Center of the screen
//     final radius = 900.sp/3; // Radius of the circle
//     final numPoints = painter.points.length;

//     double totalDistance = 0;
//     for (final point in painter.points) {
//       final distance = (point - center).distance - radius;
//       totalDistance += distance.abs();
//     }

//     final averageDistance = totalDistance / numPoints;
//     final accuracy = (1 - averageDistance / radius) * 100;

//     return accuracy.clamp(0, 100);
//   }
// }

// class MyCustomPainter extends CustomPainter {

//   List<Offset> points = [];

//   MyCustomPainter({required this.points});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 4.0
//       ..strokeCap = StrokeCap.round;

//     for (int i = 0; i < points.length - 1; i++) {
//       canvas.drawLine(points[i], points[i + 1], paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class CirclePainter extends CustomPainter {
//   static int index=0;
//   static void p(){
//     print('hello index : $index');
//   }
//   final Paint _paint;
//   final List<Offset> points = [];

//   CirclePainter() : _paint = Paint()
//     ..color = Colors.yellow
//     ..strokeWidth = 5.0
//     ..style = PaintingStyle.stroke;

//   final _paint2 = Paint()
//     ..color = Colors.black
//     ..strokeWidth = 3.0
//     ..style = PaintingStyle.stroke;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 3;
//     canvas.drawCircle(center, radius, _paint);

//     for (int i = 0; i < points.length - 1; i++) {
//       canvas.drawLine(points[i], points[i + 1], _paint2);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;

//   void addPoint(Offset point) {
//     points.add(point);
//   }

//   void reset() {
//     //points.clear();
//   }
// }

