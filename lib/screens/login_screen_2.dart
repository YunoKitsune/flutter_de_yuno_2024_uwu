import 'package:flutter/material.dart';

class LoginScreen2 extends StatelessWidget {
  const LoginScreen2({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Topicos Avanzados'),),
      //Drawer es del lado izquierdo, endDrawer es del lado derecho
      drawer: menuLateral(context),
    );
  }

  Drawer menuLateral(BuildContext context){
    return Drawer(
      child: Container(
        /*decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/love_live.jpg')
                )
              ),*/
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text('Rubensin Torres Frias'), 
              accountEmail: Text('ruben.torres@itcelaya.edu.mx')
              ),
              ListTile(
                title: Text('Login'),
                subtitle: Text('Direccion de youtube'),
                tileColor: Colors.greenAccent,
                leading: Icon(Icons.key),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, "/login2"),
              )
          ]
        ),
      ),
    );
  }

}