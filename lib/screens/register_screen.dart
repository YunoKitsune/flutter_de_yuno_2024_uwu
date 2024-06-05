import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  XFile? imageFile;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController txtUserControl = TextEditingController();
  final TextEditingController txtEmailControl = TextEditingController();
  final TextEditingController txtPwdControl = TextEditingController();
  final TextEditingController txtGitControl = TextEditingController();
  final TextEditingController txtTelControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Screen'),),
      body: Container( //Aqui irá todo el contenido
        //Estos son las cosas opara que se vea bien
        padding: const EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //Fondo del Screen
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xCA303650),
            Color(0x7FB42053),
          ]),
        ),

        //Aqui va el formulario
        child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 30,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xED167200),
                  backgroundImage: imageFile != null
                  ? FileImage(File(imageFile!.path))
                  : AssetImage('assets/giphy.gif') as ImageProvider
                ),
              ),
              Positioned(
                top: 120,
                child: ElevatedButton(
                    onPressed: () {
                      _showChoiceDialog(context);
                      },
                    child: Text("Seleccione una imagen")
                )
              ),
              Positioned(
                top: 170,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 360,
                  width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: txtUserControl,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: 'Nombre completo del usuario',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return 'Usuario invalido';
                              }
                              return null;
                            },
                          ),
                        TextFormField(
                            controller: txtEmailControl,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'Correo del usuario',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un correo';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Por favor ingrese un correo válido';
                              }
                              return null;
                            },
                        ),
                          TextFormField(
                            controller: txtPwdControl,
                            obscureText: true,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.key),
                              hintText: 'Contraseña',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese una contraseña';
                              } else if (value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: txtGitControl,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.terminal),
                              hintText: 'Página de github',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese una página de GitHub';
                              } else if (!value.startsWith('www.github.com')) {
                                return 'La página de GitHub debe empezar con "www.github.com"';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: txtTelControl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.phone),
                              hintText: 'Teléfono',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un número de teléfono';
                              } else if (value.length != 10 || !RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'El número de teléfono debe tener 10 dígitos';
                              }
                              return null;
                            },
                          ),
                          //txtUser, txtEmail, txtPwd, txtGit, txtTel
                        ],
                      ),
                    ),
                )
              ),
              Positioned(
                  top: 550,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Usuario correcto'))
                        );
                      }
                    },
                    child: Text("Validar usuario"),
                  ))
            ]
        ),

      ),

    );
  }

  _openGallery (BuildContext context) async{
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image;
    });
    Navigator.of(context).pop();
  }

  _openCamera (BuildContext context) async{
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = image;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seleccione"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap:() {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(9.0),),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: (){
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
  final txtUser = TextFormField(
    decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Nombre completo del usuario',
        hintStyle: TextStyle(fontWeight: FontWeight.bold),

    ),
  );

  final txtEmail = TextFormField(
    obscureText: true,
    decoration: const InputDecoration(
        icon: Icon(Icons.email),
        hintText: 'Correo del usuario',
        hintStyle: TextStyle(fontWeight: FontWeight.bold)
    ),
  );

  final txtPwd = TextFormField(
    obscureText: true,
    decoration: const InputDecoration(
        icon: Icon(Icons.key),
        hintText: 'Contraseña',
        hintStyle: TextStyle(fontWeight: FontWeight.bold)
    ),
  );

  final txtGit = TextFormField(
    obscureText: true,
    decoration: const InputDecoration(
        icon: Icon(Icons.terminal),
        hintText: 'Página de github',
        hintStyle: TextStyle(fontWeight: FontWeight.bold)
    ),
  );

  final txtTel = TextFormField(
    obscureText: true,
    decoration: const InputDecoration(
        icon: Icon(Icons.phone),
        hintText: 'Teléfono',
        hintStyle: TextStyle(fontWeight: FontWeight.bold)
    ),
  );

}
