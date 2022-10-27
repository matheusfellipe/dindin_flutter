import 'package:flutter/material.dart';
import 'package:din_din_com/models/user/user.dart';
import 'package:din_din_com/models/user/user_services.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final UserLocal userLocal = UserLocal();
  final UserServices userServices = UserServices();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Registrar Usuário')),
        body: SizedBox(
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Nome Completo',
                      ),
                      enabled: true,
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Campo deve ser preenchido!!!';
                        } else if (name.trim().split('').length <= 1) {
                          return 'Preencha com seu nome completo';
                        }
                        return null;
                      },
                      onSaved: (name) => userLocal.name = name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      enabled: true,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Campo deve ser preenchido!!!';
                        }
                        return null;
                      },
                      onSaved: (email) => userLocal.email = email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                      ),
                      enabled: true,
                      validator: (password) {
                        if (password!.isEmpty) {
                          return 'Campo deve ser preenchido!!!';
                        }
                        return null;
                      },
                      onSaved: (password) => userLocal.password = password,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancelar")),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            shadowColor: Colors.red,
                            elevation: 10,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              //if(userLocal.password != userLocal.confirmPassword)
                              //executar ScaffolMessenger
                              userServices.signUp(userLocal);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Salvar"),
                        ),
                        OutlinedButton.icon(
                          label: const Text("Salvar"),
                          icon: const Icon(Icons.web),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            shadowColor: Colors.red,
                            elevation: 10,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              //if(userLocal.password != userLocal.confirmPassword)
                              //executar ScaffolMessenger
                              userServices.signUp(userLocal);
                              Navigator.of(context).pop();
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}