import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tap_2024_yuno_uwu/screens/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isValidating = false;

  @override
  Widget build(BuildContext context) {

    final txtUser = TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Correo Electronico',
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

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .75,
            fit: BoxFit.fill,
            image: AssetImage('assets/love_live.jpg')
          )
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 100,
              child: Image.asset('assets/giphy.gif', height: 100,)
              ),
              Positioned(
                bottom: 150,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      txtUser,
                      txtPwd
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 90,
                child: ElevatedButton.icon(
                  onPressed: (){
                    isValidating = !isValidating;
                    setState(() {});
                    Future.delayed(const Duration(
                      milliseconds: 1500
                    )).then((value) => Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const HomeScreen(),
                        )
                      )
                    );
                  },
                  label: const Text('Validar usuario'),
                  icon: const Icon(Icons.login)
                )
              ),
              Positioned(
                top: 120,
                child: SizedBox(
                  height: 200,
                  child: isValidating ? Image.asset('assets/comiendo.gif') : Container())
              ) 
            ],
          ),
      )
    );
  }
}