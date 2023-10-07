import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:neuro_task/constant/my_text.dart';
import 'package:neuro_task/pages/authentication/login.dart';
import 'package:neuro_task/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: prefer_typing_uninitialized_variables
var patientemail;
class SplashScren extends StatefulWidget {
  const SplashScren({super.key});

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {

   @override
  void initState() {
    getValidation().whenComplete((){
      Timer(const Duration(seconds: 2), () { 
        (patientemail == null) ? Get.to(const Login()) : Get.to(const HomePage());
      });
    });
    super.initState();
  }

  Future getValidation() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var getEmail = sharedPreferences.getString('email');
    patientemail = getEmail;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_screen.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 600.h),
              MyText(text: "Neuro Task", size: 100.sp, overflow: false, bold: true, color: Colors.white),
              SizedBox(height: 50.h),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      )
    );
  }
}