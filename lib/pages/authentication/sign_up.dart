import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:neuro_task/constant/my_text.dart';
import 'package:neuro_task/services/signup_service.dart';
import 'package:neuro_task/ui/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController ethincity = TextEditingController();
  TextEditingController gender = TextEditingController();
  
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
              image: AssetImage("assets/images/signup_image.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 200.h,left: 150.w),
                  child: MyText(text: "Create a new account", size: 70.sp, overflow: false, bold: true, color: Colors.black)
                ),
                Container(
                  margin: EdgeInsets.only(top: 0.h,left: 500.w),
                  child: MyText(text: "On Neuro Task 🧠", size: 70.sp, overflow: false, bold: true, color: Colors.black)
                ),
                SizedBox(height: 200.h),
                Container(
                  height: 1250.h,
                  width: double.maxFinite.w,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Container(
                      height: 1250.h,
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MyTextField(width: 900, text: "Email", icon: Icons.mail, controller: email, check: false),
                            SizedBox(height: 50.h),
                            MyTextField(width: 900, text: "Password", icon: Icons.key, controller: password, check: true),
                            SizedBox(height: 50.h),
                            MyTextField(width: 900, text: "Confirm Password", icon: Icons.key, controller: confirmPassword, check: true),
                            SizedBox(height: 50.h),
                            MyTextField(width: 900, text: "First Name", icon: Icons.person, controller: firstName, check: false),
                            SizedBox(height: 50.h),
                            MyTextField(width: 900, text: "Last Name", icon: Icons.people_alt_outlined, controller: lastName, check: false),
                            SizedBox(height: 50.h),
                            MyTextField(width: 900, text: "Mobile Number", icon: Icons.phone, controller: number, check: false),
                            SizedBox(height: 50.h),
                            MyTextField(width: 900, text: "Date Of Birth (DD-MM-YYYY)", icon: Icons.date_range, controller: birthDate, check: false),
                            SizedBox(height: 50.h),
                            MyTextField(width: 900, text: "Ethincity", icon: Icons.dark_mode_rounded, controller: ethincity, check: false),
                            SizedBox(height: 50.h), 
                            MyTextField(width: 900, text: "Gender", icon: Icons.male, controller: gender, check: false),
                            SizedBox(height: 500.h),
                          ],
                        ),
                      ),
                      
                    ),
                  ),
                ),
                Container(
                  height: 300.h,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Get.back();
                        }, 
                        style:ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                          ),
                        ),
                          backgroundColor: const MaterialStatePropertyAll(Colors.red),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100.w,vertical: 30.h),
                            child: MyText(text: "Back", size: 60.sp, overflow: false, bold: false, color: Colors.white)
                        ),
                      ),
                     InkWell(
                      onTap: (){
                        setState(() {
                          SignUpService().firebaseSignUp(email.text, password.text,confirmPassword.text, firstName.text, lastName.text, number.text, birthDate.text, ethincity.text, gender.text).whenComplete((){
                            setState(() {
                              
                            });
                          });
                        });
                      },
                       child: Container(
                        height: 130.h,
                        width: 450.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                        ),
                        child: (SignUpService.isLoading) ? Padding( padding: EdgeInsets.symmetric(horizontal: 50.w) ,child: const Center( child: CircularProgressIndicator(color: Colors.white,))) :  
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100.w,vertical: 30.h),
                              child: MyText(text: "Signup", size: 60.sp, overflow: false, bold: false, color: Colors.white),
                          ),
                       ),
                     )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}