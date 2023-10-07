import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neuro_task/constant/ip.dart';
import 'package:http/http.dart' as http;
import 'package:neuro_task/pages/splash_screen.dart';

class MemoryGameService{

  static var ip = IP.ip;
  static Future<void> memoyGameData(String gameId,var patientId,String deviceTime,int success,int screenLocation,int cardNumber,int cardRegion) async{
    try{
      var url = 'http://$ip/Neuro_task/memory_game.php';
      var res = await http.post(Uri.parse(url),body: {
        'game_id' : gameId,
        'p_id' : patientId,
        'device_time' : deviceTime,
        'success' : success.toString(),
        'screen_location' : screenLocation.toString(),
        'card_no' : cardNumber.toString(),
        'card_region' : cardRegion.toString(),
      });
      if(res.body == 'success'){
        // ignore: avoid_print
        print('success');
      }
      else{
        // ignore: avoid_print
        print('error');
      }
    }
    catch(e){
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<void> memoryGameDataFirebase(String gameId,var patientId,String deviceTime,int success,int screenLocation,int cardNumber,int cardRegion) async{
    DateTime currentTime = DateTime.now();
    int miliSecond = currentTime.millisecondsSinceEpoch;
    try{
      FirebaseFirestore.instance.collection('Memory Game - $patientemail').doc(miliSecond.toString()).set({
        'game_id' : gameId,
        'p_id' : patientId,
        'device_time' : deviceTime,
        'success' : success.toString(),
        'screen_location' : screenLocation.toString(),
        'card_no' : cardNumber.toString(),
        'card_region' : cardRegion.toString(),
      }).then((value) => {
        // ignore: avoid_print
        print('seccess'),
      }).catchError((error)=>{
        // ignore: avoid_print
        print(error),
      });
    }
    catch(e){
      // ignore: avoid_print
      print(e);
    }
  }
}