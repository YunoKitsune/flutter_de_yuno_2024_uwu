import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tap_2024_yuno_uwu/models/popular_model.dart';

class ApiPopular{
  Uri uri = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=e5e00205ee452d595b4798495baa3a2e&language=es-MX&page=1');

  Future<List<PopularModel>?> getAllPopular() async {

    Response response = await  http.get(uri);

    if( response.statusCode == 200){
      final jsonPopular = jsonDecode(response.body)['results'] as List;
      return jsonPopular.map((popular) => PopularModel.fromMap(popular)).toList();
      //La linea anterior es una funcion que funciona como un ciclo recorriendo cada llave de la api que este en "results"
      //El popular chiquito es como la variable auxiliar que va a contener un "{}" de la api, hacerlo PopularModel y ponerlo en una lista.
    }
    return null;
  }
}