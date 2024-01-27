import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_task/constant/responsive.dart';
import 'package:neuro_task/pages/homepage.dart';
import 'package:neuro_task/services/target_game_services.dart';
import 'package:neuro_task/ui/game/game_start_message.dart';

class TargetGame extends StatefulWidget {
  const TargetGame({super.key});

  @override
  State<TargetGame> createState() => _TargetGameState();
}

class _TargetGameState extends State<TargetGame> {

  double positionX = 0.0;
  double positionY = 0.0;
  Random random = Random();
  int index = 0;
  Map<double,double> circleSize = {
    0.1 : 0.05,
    0.09 : 0.045,
    0.095 : 0.0475,
    0.08 : 0.04,
  };
  void getRandomPosition(){
    index = random.nextInt(4);
    //debugPrint('index: $index');
    positionX = (0 + random.nextDouble() * (0.8 - 0));
    positionY = (0.1 + random.nextDouble() * (0.8 - 0.1));
  }
  @override
  void initState() {
    getRandomPosition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = Responsive.screenHeight(context);
    double width = Responsive.screenWidth(context);
    return Scaffold(
      body: GestureDetector(
        onTapUp: (TapUpDetails details) {
          Offset tapPosition = details.globalPosition;
          debugPrint('Container Position: (${(positionX*width)+(height * circleSize.values.elementAt(index))} ${(positionY*height)+(height * circleSize.values.elementAt(index))})');
          debugPrint("Tap Position Outside: (${tapPosition.dx}, ${(tapPosition.dy)-(height * 0.1)})");
          TargetGameServices.targetGameDataFirebase(
            patientId,
            0,
            ((positionX*width)+(height * circleSize.values.elementAt(index))),
            ((positionY*height)+(height * circleSize.values.elementAt(index))),
            (tapPosition.dx),
            ((tapPosition.dy)-(height * 0.1)),
            (circleSize.values.elementAt(index)),
          );
        },
        child: Container(
          height: height * 1,
          width: width * 1,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.1,
                width: width * 1,
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Get.to(const HomePage());
                      },
                      child: Text("Back",
                      style: TextStyle(
                        fontSize: (width / Responsive.designWidth) * 30,
                        color: const Color.fromARGB(166, 207, 207, 11),
                        ),
                      )
                      ),
                    InkWell(
                    onTap: (){
                      GameStartMessage.startMessage(context,"Target Game","");
                    },
                      child: Container(
                      height: height * 0.05,
                      width: width * 0.1,
                      margin: EdgeInsets.only(bottom: height * 0.005),
                      color: Colors.transparent,
                      child: const FittedBox(
                        child: Icon(CupertinoIcons.info,color: Color.fromARGB(166, 207, 207, 11),),
                      ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Get.to(const HomePage());
                      },
                      child: Text("Submit",
                      style: TextStyle(
                          fontSize: (width/Responsive.designWidth) * 30,
                          color: const Color.fromARGB(166, 207, 207, 11),
                          ),
                      )
                    ),
                  ],
                ),
              ),
              GestureDetector(
                //behavior: HitTestBehavior.translucent,
                onTapUp: (TapUpDetails details) {
                  debugPrint('Container Position: (${(positionX*width)+(height * circleSize.values.elementAt(index))} ${(positionY*height)+(height * circleSize.values.elementAt(index))})');
                  Offset tapPosition = details.globalPosition;
                  debugPrint("Tap Position Inside: (${tapPosition.dx}, ${(tapPosition.dy)-(height * 0.1)})");
                  TargetGameServices.targetGameDataFirebase(
                    patientId,
                    1,
                    ((positionX*width)+(height * circleSize.values.elementAt(index))),
                    ((positionY*height)+(height * circleSize.values.elementAt(index))),
                    (tapPosition.dx),
                    ((tapPosition.dy)-(height * 0.1)),
                    (circleSize.values.elementAt(index)),
                  );
                  getRandomPosition();
                  setState(() {});
                  
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: height * circleSize.keys.elementAt(index),
                  width: height * circleSize.keys.elementAt(index),
                  margin: EdgeInsets.only(left: (width * positionX),top: height * positionY),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                  ),     
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: height * (circleSize.keys.elementAt(index)-0.03),
                      width: height * (circleSize.keys.elementAt(index)-0.03),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: height * (circleSize.keys.elementAt(index)-0.06),
                          width: height * (circleSize.keys.elementAt(index)-0.06),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}