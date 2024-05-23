import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tap_2024_yuno_uwu/models/popular_model.dart';


class PopularView extends StatelessWidget {
   PopularView({super.key, this.popularModel});

  PopularModel? popularModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack( //Era un column, pero le cambiamos el nombre a stack
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              imageUrl: 'https://image.tmdb.org/t/p/w500/${popularModel!.backdropPath}',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.network('https://static.animecorner.me/2021/05/ZSR-07-11.png'),
            ),
            Container(
              height: 60,
              color: Colors.black54,
              child: ListTile(
                leading:const Icon(Icons.movie, color: Colors.white,),
                title: Text(popularModel!.title, style: const TextStyle(color: Colors.white),),
                subtitle: Text(popularModel!.releaseDate, style: const TextStyle(color: Colors.white), maxLines: 1,),
                trailing: IconButton(
                  onPressed:() => Navigator.pushNamed(context, '/detail', arguments: popularModel ),
                  icon: const Icon(Icons.chevron_right),
                  color: Colors.white,
                  ),
              ),
            )
          ],
        ),
      )
      //Image.network('${popularModel!.backdropPath}'),
    );
  }
}