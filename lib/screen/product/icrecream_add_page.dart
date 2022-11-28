// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:din_din_com/models/product/icecream.dart';
import 'package:din_din_com/models/product/icecream_service.dart';
// ignore: depend_on_referenced_packages

class IceCreamAddPage extends StatefulWidget {
  const IceCreamAddPage({Key? key, data}) : super(key: key);

  @override
  State<IceCreamAddPage> createState() => _IceCreamAddPageState();
}

class _IceCreamAddPageState extends State<IceCreamAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
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
                  initialValue: _icecream.sabor,
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
                  keyboardType: TextInputType.number,
                  initialValue: _icecream.unit,
                  decoration: InputDecoration(
                    hintText: 'Unidade',
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
                  initialValue: _icecream.price,
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
                Row(
                  children: [
                    const Text('Ativo'),
                    Checkbox(
                      checkColor: Colors.white,
                      // fillColor: MaterialStateProperty.resolveWith(Colors.blue),
                      value: _icecream.active ?? true,
                      onChanged: (value) {
                        setState(() {
                          _icecream.active = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width > 650
                      ? 500
                      : MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height > 650
                      ? 350
                      : MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _pickedImage == null || webImage.isEmpty
                      ? dottedBorder(color: Colors.blue)
                      : Card(
                          elevation: 1,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: kIsWeb
                                ? Image.memory(webImage)
                                : Image.file(_pickedImage!),
                          ),
                        ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _pickedImage = null;
                    });
                  },
                  child: const Text("Limpar Imagem",
                      style: TextStyle(color: Colors.purple)),
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

                          IcecreamService _icecreamService =
                              IcecreamService(); //chama a regra de salvar
                          bool ok = await _icecreamService.add(
                              icecream: _icecream,
                              imageFile: kIsWeb ? webImage : _pickedImage,
                              plat:
                                  kIsWeb); //passa o objeto para salvar no serviço add
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

  Widget dottedBorder({required Color color}) {
    return DottedBorder(
      dashPattern: const [6],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      color: color,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                color: color,
                size: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: Text(
                    "Escolha uma Imagem para o produto",
                    style: TextStyle(color: color),
                  ))
            ]),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var imageSelected = File(image.path);
        setState(() {
          _pickedImage = imageSelected;
        });
      }
    } else if (kIsWeb) {
      ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var imageSelected = await image.readAsBytes();
        setState(() {
          webImage = imageSelected;
          _pickedImage = File('a');
        });
      } else {
        debugPrint('Nenhuma image foi selecionda');
      }
    } else {
      debugPrint('Algo errado aconteceu!');
    }

    //   try {
    //     pickedImage = await picker.pickImage(
    //         source: inputSource == 'camera'
    //             ? ImageSource.camera
    //             : ImageSource.gallery,
    //         maxWidth: 1920);

    //     fileName = path.basename(pickedImage!.path);
    //     imageFile = File(pickedImage.path);

    //     // Refresh the UI
    //     setState(() {});
    //   } catch (err) {
    //     if (kDebugMode) {
    //       print(err);
    //     }
    //   }
  }
}
