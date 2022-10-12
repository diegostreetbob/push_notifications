////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push_notifications/screens/screens_barrel.dart';
import 'package:push_notifications/services/services_barrel.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //obtención del token de firebase messaging
  PushNotificationService.initApp();
  runApp(MyApp());
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();
  @override
  void initState(){
    super.initState();
    //aquí tengo acceso al context y me subscribo al stream del servicio
    PushNotificationService.msgStream.listen((message) {
      print("notification.title:${message.notification?.title ?? ""}");//si no viene muestro en blanco
      print("notification.body:${message.notification?.body ?? ""}");
      print("notification.data:${message.data}");
      print("notification.data['producto']: "+message.data["producto"]);
      print("notification.data['key2']: "+message.data["key2"]);
      //
      navigatorKey.currentState?.pushNamed(MessageScreen.route,arguments: message);
      //
      final SnackBar snackBar = SnackBar(content: Text(message.data["producto"]));
      //scaffoldMessengerKey.currentState!.showSnackBar(snackBar);//asi no sale el snackbar
      scaffoldMessengerKey.currentState?.showSnackBar(snackBar);//? significa que si existe muestre el snackbar

    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      navigatorKey: navigatorKey ,//navegar
      scaffoldMessengerKey: scaffoldMessengerKey,//mostrar snackbar
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route   : (_) => HomeScreen(),
        MessageScreen.route: (_) => MessageScreen()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////