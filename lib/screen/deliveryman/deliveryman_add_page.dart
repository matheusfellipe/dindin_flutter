import 'package:flutter/material.dart';
import 'package:din_din_com/models/entregador/deliveryman.dart';
import 'package:din_din_com/models/entregador/deliveryman_service.dart';

class DeliverymanAddPage extends StatefulWidget {
  const DeliverymanAddPage({Key? key}) : super(key: key);

  @override
  State<DeliverymanAddPage> createState() => _DeliverymanAddPageState();
}

class _DeliverymanAddPageState extends State<DeliverymanAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Deliveryman _deliveryman = Deliveryman();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Entregador"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    } else if (name.trim().split('').length <= 1) {
                      return 'Preencha com seu nome correto';
                    }
                    return null;
                  },
                  onSaved: (name) => _deliveryman.name = name,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'CPF',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (cpf) {
                    if (cpf!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    }
                    return null;
                  },
                  onSaved: (cpf) => _deliveryman.cpf = cpf,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Telefone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (phone) {
                    if (phone!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    }
                    return null;
                  },
                  onSaved: (phone) => _deliveryman.phone = phone,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Rota',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (route) {
                    if (route!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    } else if (route.trim().split('').length <= 1) {
                      return 'Preencha com seu nome correto';
                    }
                    return null;
                  },
                  onSaved: (route) => _deliveryman.route = route,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          DeliverymanService _deliverymanService =
                              DeliverymanService(); //chama a regra de salvar
                          bool ok = await _deliverymanService.add(
                              _deliveryman); //passa o objeto para salvar no serviço add
                          if (ok && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    content:
                                        Text("Dados gravados com sucesso!!!")));
                            _formKey.currentState!.reset();
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content:
                                        Text("Problemas ao gravar dados!!!")));
                          }
                        }
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
