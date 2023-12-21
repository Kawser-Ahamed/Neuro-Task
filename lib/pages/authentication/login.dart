import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:neuro_task/constant/my_text.dart';
import 'package:neuro_task/pages/authentication/sign_up.dart';
import 'package:neuro_task/services/login_service.dart';
import 'package:neuro_task/ui/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController resetEmail = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/login_image.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height:700.h),
              MyText(text: "Welcome To Neuro Task", size: 80.sp, overflow: false, bold: true, color: Colors.white),
              SizedBox(height:300.h),
              MyTextField(width: 800, text: "Email", icon: Icons.mail, controller: email, check: false),
              SizedBox(height:50.h),
              MyTextField(width: 800, text: "Password", icon: Icons.key, controller: password, check: true),
              SizedBox(height:80.h),
              InkWell(
                onTap: (){
                  setState(() {
                    LoginService().firebaseLogin(email.text, password.text).whenComplete((){
                      setState(() {
                        
                      });
                    });
                  });
                },
                child: Container(
                  height: 150.h,
                  width: 780.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.all(Radius.circular(50.sp))
                  ),
                  child: (LoginService.isLoading) ? const Center(child: CircularProgressIndicator(color: Colors.white,)) :
                  MyText(text: "Login", size: 60.sp, overflow: false, bold: false, color: Colors.white),
                ),
              ),
              SizedBox(height:20.h),
              TextButton(
                onPressed: (){
                  Get.defaultDialog(
                    title:  "Reset Your Password",
                    content: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: MyTextField(width: 800, text: "Enter Your Email", icon: Icons.email, controller: resetEmail, check: false)),
                      ],
                    ),
                    confirm: TextButton(
                      onPressed: (){
                        if(resetEmail.text.isEmpty){
                           Get.snackbar(
                              "Neuro Task",
                              "Please enter your email and try again",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          Navigator.pop(context);
                        }
                        else{
                          FirebaseAuth.instance.sendPasswordResetEmail(email: resetEmail.text.toString()).then((value){
                            Get.snackbar(
                              "Neuro Task",
                              "We have send you a email to reset password. Please check it.",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            Navigator.pop(context);
                            resetEmail.clear();
                          }).onError((error, stackTrace){
                            Get.snackbar(
                              "Neuro Task", 
                              "Server is busy",
                              snackPosition: SnackPosition.BOTTOM
                            );
                          });
                        }
                      }, 
                      child:MyText(text: "Send", size: 60.sp, overflow: false, bold: false, color: Colors.green), 
                    ),
                    cancel: TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child:MyText(text: "Cancel", size: 60.sp, overflow: false, bold: false, color: Colors.red), 
                    ),
                  );
                }, 
                child: MyText(text: "Forgot Password?", size: 60.sp, overflow: false, bold: true, color: Colors.red),
              ),
              TextButton(
                onPressed: (){
                  Get.to(const SignUp());
                }, 
                child: MyText(text: "Don't have any account? Signup", size: 55.sp, overflow: false, bold: false, color: Colors.deepPurple),
              ),
              SizedBox(height:20.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     MyIcon(icon: Icons.local_hospital, color: Colors.lightBlue, size: 90.sp),
              //     MyIcon(icon: Icons.medical_information, color: Colors.lightBlue, size: 90.sp),
              //     MyIcon(icon: Icons.mobile_screen_share, color: Colors.lightBlue, size: 90.sp),
              //   ],
              // ),
              SizedBox(height:40.h),
              MyText(text: " Neuro Task - 2023  © copyright Mosaic Lab", size: 40.sp, overflow: false, bold: false, color: Colors.black),
              SizedBox(height:30.h),
            ],
          ),
        ),
      )
    );
  }
}