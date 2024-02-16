import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_task/constant/my_text.dart';
import 'package:neuro_task/constant/responsive.dart';
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
    double height = Responsive.screenHeight(context);
    double width = Responsive.screenWidth(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height * 1,
          width: width * 1,
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
                  margin: EdgeInsets.only(top: height * 0.1,left: width * 0.1),
                  child: const MyText(text: "Create a new account", size: 20, bold: true, color: Colors.black,height: 0.05,width: 0.6,)
                ),
                Container(
                  margin: EdgeInsets.only(top: 0,left: width * 0.4),
                  child: const MyText(text: "On Neuro Task 🧠", size: 30, bold: true, color: Colors.black,height: 0.05,width: 1),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  height: height * 0.6,
                  width: width * 1,
                  color: Colors.transparent,
                  child:SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        MyTextField(width: 0.8, text: "Email", icon: Icons.mail, controller: email, check: false),
                        SizedBox(height: height * 0.002),
                        MyTextField(width: 0.8, text: "Password", icon: Icons.key, controller: password, check: true),
                        SizedBox(height: height * 0.002),
                        MyTextField(width: 0.8, text: "Confirm Password", icon: Icons.key, controller: confirmPassword, check: true),
                        SizedBox(height: height * 0.002),
                        MyTextField(width: 0.8, text: "First Name", icon: Icons.person, controller: firstName, check: false),
                        SizedBox(height: height * 0.002),
                        MyTextField(width: 0.8, text: "Last Name", icon: Icons.people_alt_outlined, controller: lastName, check: false),
                        SizedBox(height: height * 0.002),
                        MyTextField(width: 0.8, text: "Mobile Number", icon: Icons.phone, controller: number, check: false),
                        SizedBox(height: height * 0.002),
                        MyTextField(width: 0.8, text: "Date Of Birth (DD-MM-YYYY)", icon: Icons.date_range, controller: birthDate, check: false),
                        SizedBox(height: height * 0.002),
                        MyTextField(width: 0.8, text: "Ethincity", icon: Icons.dark_mode_rounded, controller: ethincity, check: false),
                        SizedBox(height: height * 0.002),
                        MyTextField(width: 0.8, text: "Gender", icon: Icons.male, controller: gender, check: false),
                        SizedBox(height: height * 0.002),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //height: height * 0.25,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: width * 0.03),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (){
                              Get.back();
                            }, 
                            style:ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular((width/Responsive.designWidth)*20)),
                              ),
                            ),
                              backgroundColor: const MaterialStatePropertyAll(Colors.red),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.01),
                                child: const MyText(text: "Back", size: 30, bold: false, color: Colors.white,height: 0.05,width: 0.4,)
                            ),
                          ),
                        ),
                       SizedBox(width: width * 0.05,),
                       Expanded(
                         child: InkWell(
                          onTap: (){
                            setState(() {
                              SignUpService().firebaseSignUp(email.text, password.text,confirmPassword.text, firstName.text, lastName.text, number.text, birthDate.text, ethincity.text, gender.text).whenComplete((){
                                setState(() {
                                  
                                });
                              });
                            });
                          },
                           child: Container(
                            height: height * 0.072,
                            width: width * 4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.all(Radius.circular((width/Responsive.designWidth) * 20)),
                            ),
                            child: (SignUpService.isLoading) ? Padding( padding: EdgeInsets.symmetric(horizontal: height * 0.05) ,child: const Center( child: CircularProgressIndicator(color: Colors.white,))) :  
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                  child: MyText(text: "Signup", size: 30, bold: false, color: Colors.white,height: 0.05,width: 0.5),
                              ),
                           ),
                         ),
                       ),
                       SizedBox(width: width * 0.03),
                      ],
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