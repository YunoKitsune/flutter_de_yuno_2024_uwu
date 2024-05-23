import 'package:flutter/material.dart';
import 'package:tap_2024_yuno_uwu/screens/home_screen.dart';
import 'package:tap_2024_yuno_uwu/screens/intenciones_screen.dart';
import 'package:tap_2024_yuno_uwu/screens/login_screen_2.dart';
import 'package:tap_2024_yuno_uwu/screens/login_screen_tarea.dart';
import 'package:tap_2024_yuno_uwu/screens/movie_detail_screen.dart';
import 'package:tap_2024_yuno_uwu/settings/theme_settings.dart';
import 'package:tap_2024_yuno_uwu/settings/value_listener.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ValueListener.isDark,
        builder: (context, value, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              //home: const SplashScreen(),
              home: LoginScreenTarea(),
              theme: value
                  ? ThemeSettings.darkTheme(context)
                  : ThemeSettings.lightTeme(context),
              routes:{
                "/home" :(context) => const HomeScreen(),
                "/login2" :(context) => const LoginScreen2(),
                "/intent" :(context) => const IntencionesScreen(),
                "/detail" :(context) => const MovieDetailScreen(),
                "/tarea_tutorial_>w<" :(context) => const LoginScreenTarea(),
              }
          );
        }
    );
  }
}