
import 'package:apna_food/Authentications/Signup.dart';
import 'package:apna_food/Authentications/login.dart';
import 'package:apna_food/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure the Flutter bindings are initialized before interacting with Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the options
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCYqOAx7ZEJJS3vlj8HSbhojhduX9xTsqA",
      appId:"1:585666853080:android:00184062072bdfcb247fad" ,
      messagingSenderId: "585666853080",
      projectId: "fooddeliveryapp-a9104",
    ),
  );

  // Run the app after Firebase is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apna Food',
      home: Home(),
    );
  }
}
