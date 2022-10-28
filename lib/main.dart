// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screen/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  const firebaseConfig = FirebaseOptions(
      apiKey: "AIzaSyBQJKlCrSq7xvF1DLPcCExBpDjkZhBW9eY",
      authDomain: "dindin-com.firebaseapp.com",
      projectId: "dindin-com",
      storageBucket: "dindin-com.appspot.com",
      messagingSenderId: "94268004754",
      appId: "1:94268004754:web:6a3bd5e0db3af096aec94b",
      measurementId: "G-KV6DGVD8FN");

 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
