////////////////////////////////////////////////////////////////////////////////////////////////////
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
class PushNotificationService {
  //
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  //se puede enviar todo tipo de objetos
  static StreamController<RemoteMessage> _msgStream = new StreamController.broadcast();
  static Stream<RemoteMessage> get msgStream => _msgStream.stream;//getter
  //para cuando la aplicación esté en segundo plano
  static Future _backGroundHandler(RemoteMessage message)async{
    //print("OnBackGroundHanler:${message.messageId}");
    //añado info al stream
    _msgStream.sink.add(message);
  }
  //para cuando la aplicación esté en primer plano
  static Future _onMessageHandler(RemoteMessage message)async{
    //print("OnMessageHandler:${message.messageId}");
    //añado info al stream
    _msgStream.sink.add(message);//si no viene el titulo envio en blanco

  }
  //para cuando la aplicación
  static Future _onMessageOpenAppHandler(RemoteMessage message)async{
    //print("OnMessageOpenAppHandler:${message.messageId}");
    //añado info al stream
    _msgStream.sink.add(message);//si no viene el titulo envio en blanco
  }
  static Future  initApp() async{
    //Push notifications
    await Firebase.initializeApp();
    token = await messaging.getToken();
    //identificador único de este dispositivo, en este caso:
    //ezsXI-D-Tf2dUT462hk6pI:APA91bF5IWQfB5GZEdbO9_tf-DEUV1rnP8UIBfyxGrLJQvLjiDao_lc-GorZoQj_-ottJDfJY-cLXh1wkgvQ_fr5BlfdYNBoY092B_C1xeZApHwoDO9PIvCISAqUxJhgR9kY12EKmNF_
    //print("token:$token");
    //handlers
    //aplicación en background
    FirebaseMessaging.onBackgroundMessage(_backGroundHandler);
    //aplicacion cerrada
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    //aplicación abierta
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenAppHandler);
    //Local notifications
  }




}
////////////////////////////////////////////////////////////////////////////////////////////////////
