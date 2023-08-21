import 'package:camera/camera.dart';
import 'package:firstapptwo/camera/camera.dart';
import 'package:firstapptwo/firestoreData.dart';
import 'package:firstapptwo/loginFLow.dart';
import 'package:firstapptwo/otpLogin.dart';
import 'package:firstapptwo/staggeredGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myHomePage.dart';
import 'package:firstapptwo/todoListScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
  );
  runApp(
      ChangeNotifierProvider(
        create: (context) => CameraProvider(),
        child: MyApp(),
      )
  ); // First class to run
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Check it out",
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        'MyHomePage': (context) => MyHomePage(), // Define route for MyHomePage
        '/': (context)=>LoginFlow(),
        // '/': (context)=>StaggeredGridViewExample(),
        // '/': (context)=>LoginWithPhone(),
        // '/': (context)=>FireWrite(),

        // '/': (context)=>CameraApp(),

        '/todos': (context) => TodosScreen()
         // Define route for TodosScreen
      },
    );
  }
}

///firebase,firestore,todoList, OTP login, staggered grid integrate into a better flow




