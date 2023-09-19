import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neuro_task/constant/ip.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:neuro_task/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpService{

  var ip = IP.ip;
  Future<void> signUp(String email,String password,String confirmPassword,String firstName, String lastName,String mobile,String birthDate,String ethincity,String gender) async{
    
    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty || firstName.isEmpty || lastName.isEmpty || mobile.isEmpty || birthDate.isEmpty || ethincity.isEmpty || gender.isEmpty){
      Get.snackbar('Neuro Task', 'Please fill all the input box');
    }
    else if(!email.contains('@gmail.com')){
      Get.snackbar('Neuro Task', 'Invalid email address');
    }
    else if(password!=confirmPassword){
      Get.snackbar('Neuro Task', "Password and confirm password is not same");
    }
    else if(password.length<8){
      Get.snackbar('Neuro Task', "Weak Password");
    }
    else{
      var url = "http://$ip/Neuro_Task/sign_up.php";
        try{
          var res = await  http.post(Uri.parse(url),body: {
            'email' : email,
            'password' : password,
            'first_name' : firstName,
            'last_name' : lastName,
            'mobile_number' : mobile,
            'date_of_birth' : birthDate,
            'ethincity' : ethincity,
            'gender' : gender,
          });

          if(res.body== 'email already exist'){
            Get.snackbar('Neuro Task', 'Email already exist');
          }
          else if(res.body== 'error'){
            Get.snackbar('Neuro Task', 'Server Down');
          }
          else if(res.body=='success'){
            Get.snackbar('Neuro Task', 'Account creation sucessfull');
            Get.to(const HomePage());
          }
          else{
            Get.snackbar('Neuro Task', 'Error');
          }
        }
        catch(e){
          // ignore: avoid_print
          print(e);
        }
    }
  }
  
  Future<void> firebaseSignUp(String email,String password,String confirmPassword,String firstName, String lastName,String mobile,String birthDate,String ethincity,String gender) async{
     DateTime currentTime = DateTime.now();
     int id = currentTime.microsecondsSinceEpoch;
    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty || firstName.isEmpty || lastName.isEmpty || mobile.isEmpty || birthDate.isEmpty || ethincity.isEmpty || gender.isEmpty){
      Get.snackbar('Neuro Task', 'Please fill all the input box');
    }
    else if(!email.contains('@gmail.com')){
      Get.snackbar('Neuro Task', 'Invalid email address');
    }
    else if(password!=confirmPassword){
      Get.snackbar('Neuro Task', "Password and confirm password is not same");
    }
    else if(password.length<8){
      Get.snackbar('Neuro Task', "Weak Password");
    }
    else{
      try{
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('email', email);
        Get.snackbar('Neuro Task', 'Your Account Creation Successfull');
        Get.to(const HomePage());
        user.user!.sendEmailVerification();

        FirebaseFirestore.instance.collection(email).doc(id.toString()).set({
          'Patient Id' : id.toString(),
          'First Name' : firstName,
          'Last Name' : lastName,
          'Date Of Birth (DD-MM-YYYY)' : birthDate,
          'Mobile Number' : mobile,
          'Ethincity' : ethincity,
          'Gender' : gender
        });
      }on FirebaseAuthException catch(e){
        if(e.code == 'weak-password'){
          Get.snackbar('Weak Password', 'Your Password Is Weak');
        }
        else if(e.code == 'email-already-in-use'){
          Get.snackbar('Reused Email', 'Your Email Is Already Used',
        );
        }
      } catch (error) {
        Get.snackbar('Error', 'FoodFrenzy Server is Down');
      }
    }
  }

}