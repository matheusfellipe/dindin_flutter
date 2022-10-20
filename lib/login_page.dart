// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Colors.purple[300],
      
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Text('Hello World',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
            ),
          ]),
        ),
      ),
    );
  }
}