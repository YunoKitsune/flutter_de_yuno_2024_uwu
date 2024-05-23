import 'package:flutter/material.dart';
import 'package:tap_2024_yuno_uwu/models/popular_model.dart';
import 'package:tap_2024_yuno_uwu/network/api_popular.dart';
import 'package:tap_2024_yuno_uwu/views/popular_view.dart';


class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular(); //apiPopular = new ApiPopular();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peliculas populares'),),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(), //Con el ! le decimos que a fuerzas debe estar instanciado, sino nos da error
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) { //Esta es la pantalla inicial
          if(snapshot.hasData){
            //return Text('Tiene datos, y aqui van los datos ^w^');
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => PopularView(popularModel: snapshot.data![index],),
            );
          } else{
            if(snapshot.hasError){
              return Text('${snapshot.error}');
            } else{ // En caso que todavia se está ejecutando la peticion
              return const Center(child: CircularProgressIndicator(),); //Indicador de cargando O.O
            }
          }
        }, 
        ), 
    );
  }
}