import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CategoriasDB{

  static final NAMEDB = "TaqueriaDB";
  static final VERSIONDB = 1;

  /*static Database? _database; //Cuando tiene un guion bajo es que el atributo es privado
  Future<Database> get database async {
     if( _database != null) return _database!;
     return _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async{
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, NAMEDB);
  }*/
  
}