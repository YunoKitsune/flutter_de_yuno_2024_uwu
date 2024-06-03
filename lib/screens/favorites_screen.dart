import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<dynamic> favoriteMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavoriteMovies();
  }

  Future<void> fetchFavoriteMovies() async {
    var headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNWUwMDIwNWVlNDUyZDU5NWI0Nzk4NDk1YmFhM2EyZSIsInN1YiI6IjY1NWQzMjJlZDRmZTA0MDBhYzM5YWI5OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2zNI6X7VnEvQk-XYXXBQpXKfPRs5SOJplI--1MWhg2Y'
    };
    var request = http.Request(
        'GET',
        Uri.parse('https://api.themoviedb.org/3/account/20731196/favorite/movies?api_key=e5e00205ee452d595b4798495baa3a2e')
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      setState(() {
        favoriteMovies = json.decode(responseBody)['results'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteMovies[index]['title']),
            subtitle: Text(favoriteMovies[index]['release_date']),
            leading: favoriteMovies[index]['poster_path'] != null
                ? Image.network(
              'https://image.tmdb.org/t/p/w92${favoriteMovies[index]['poster_path']}',
              fit: BoxFit.cover,
            )
                : null,
          );
        },
      ),
    );
  }
}