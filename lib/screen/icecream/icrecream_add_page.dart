import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:din_din_com/models/icrecream/icecream.dart';
import 'package:din_din_com/models/icrecream/icecream_service.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class IceCreamAddPage extends StatefulWidget {
  const IceCreamAddPage({Key? key}) : super(key: key);

  @override
  State<IceCreamAddPage> createState() => _IceCreamAddPageState();
}

class _IceCreamAddPageState extends State<IceCreamAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Icecream _icecream = Icecream();
  late final String fileName;
  late File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Cremosinho"),
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
                    hintText: 'Sabor',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (sabor) {
                    if (sabor!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    } else if (sabor.trim().split('').length <= 1) {
                      return 'Preencha com seu nome correto';
                    }
                    return null;
                  },
                  onSaved: (sabor) => _icecream.sabor = sabor,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Tipo da Unidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (unit) {
                    if (unit!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    }
                    return null;
                  },
                  onSaved: (unit) => _icecream.unit = unit,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Preço do produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (price) {
                    if (price!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    }
                    return null;
                  },
                  onSaved: (price) => _icecream.price = price,
                ),
                const SizedBox(
                  height: 20,
                ),
                Checkbox(
                  checkColor: Colors.black,
                  // fillColor: MaterialStateProperty.resolveWith(Colors.blue),
                  value: _icecream.active=true,
                  onChanged: (bool? value) {
                    setState(() {
                      _icecream.active = value!;
                    });
                  },
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
                          IcecreamService icecreamService = IcecreamService();
                          bool ok = await icecreamService.add(
                              _icecream, imageFile, kIsWeb);
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
                    ElevatedButton.icon(
                        onPressed: () => _upload('camera'),
                        icon: const Icon(Icons.camera),
                        label: const Text('camera')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      fileName = path.basename(pickedImage!.path);
      imageFile = File(pickedImage.path);

      // Refresh the UI
      setState(() {});
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
