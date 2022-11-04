// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:din_din_com/models/user/user.dart';
import 'package:din_din_com/models/user/user_services.dart';
import 'package:din_din_com/screen/login/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserLocal _userLocal = UserLocal();

  final UserServices _userServices = UserServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Seja bem vindo ao Din Din Com',
              style: GoogleFonts.bebasNeue(
                fontSize: 36,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'É uma alegria ser seu parceiro',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                          enabled: true,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return 'Campo deve ser preenchido!!!';
                            }
                            return null;
                          },
                          onSaved: (email) => _userLocal.email = email,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Senha',
                          ),
                          enabled: true,
                          validator: (password) {
                            if (password!.isEmpty) {
                              return 'Campo deve ser preenchido!!!';
                            }
                            return null;
                          },
                          onSaved: (password) => _userLocal.password = password,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 185.0, vertical: 20.0))),
                    onPressed: () async {
                      debugPrint('Entrou no sistema');
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        debugPrint(_userLocal.toString());
                        bool ok = await _userServices.signIn(_userLocal);
                        if (ok) {
                          if (mounted) {
                            debugPrint('Logado no sistema');
                          }
                        }
                      }
                    },
                    child: Text('Entrar'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Não está cadastrado?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    ' Registrar agora',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
