import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tap_2024_yuno_uwu/settings/value_listener.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                onTap: () => Navigator.pushNamed(context, "/home"),
              ),
              ListTile(
                title: Text('Intenciones'),
                subtitle: Text('Acciones implicitas'),
                tileColor: Colors.greenAccent,
                leading: Icon(Icons.abc),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, "/intent"),
              ),
              DayNightSwitcher(
                isDarkModeEnabled: ValueListener.isDark.value, 
                onStateChanged: (isDarkModeEnabled) {
                  ValueListener.isDark.value = isDarkModeEnabled;
                }
              )
          ]
        ),
        
      ),
    );
  }

}