import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tap_2024_yuno_uwu/models/person_credits.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/popular_model.dart';

import '../models/credits.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;
  late Future<List<String>> _trailerUrls;
  late Future<Credits> _movieCredits;
  final String accountId = '20731196';
  final String apiKey = 'e5e00205ee452d595b4798495baa3a2e';
  final String sessionId = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final popularModel =
    ModalRoute.of(context)!.settings.arguments as PopularModel;
    _trailerUrls = fetchTrailers(popularModel.id);
    _movieCredits = fetchCredits(popularModel.id);
    _loadFavoriteStatus(popularModel.id);
  }

  Future<List<String>> fetchTrailers(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];
      return results
          .where((video) => video['site'] == 'YouTube')
          .map<String>((video) => video['key'])
          .toList();
    } else {
      throw Exception('Fallo al cargar los trailers');
    }
  }

  Future<Credits> fetchCredits(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Credits.fromJson(data);
    } else {
      throw Exception('Fallo al cargar los créditos');
    }
  }

  Future<void> addFavorite({
    required String accountId,
    required String apiKey,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool favorite,
  }) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/account/$accountId/favorite?session_id=$sessionId',
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNWUwMDIwNWVlNDUyZDU5NWI0Nzk4NDk1YmFhM2EyZSIsInN1YiI6IjY1NWQzMjJlZDRmZTA0MDBhYzM5YWI5OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2zNI6X7VnEvQk-XYXXBQpXKfPRs5SOJplI--1MWhg2Y'
      },
      body: jsonEncode({
        'media_type': mediaType,
        'media_id': mediaId,
        'favorite': favorite,
        'api_key': apiKey
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status_code'] == 1) {
        print('Success: ${responseBody['status_message']}');
        print('Exito');
      } else {
        print('Failed: ${responseBody['status_message']}');
        print('Error');
      }
    } else {
      print('Fallo con el status code: ${response.statusCode}');
    }
  }

  Future<bool> _loadFavoriteStatus(int mediaId) async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/account/$accountId/favorite/movies?api_key=$apiKey&session_id=$sessionId'),
        headers: {
          'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MDEzMzg1YWE3YmYxMGIzYjQ2YjE2MjM5YzIyZTIyYyIsInN1YiI6IjY1NWQxNzM0N2YwNTQwMThkNDIxYzg5YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BHHTtvQyhOqTTnMPmxoXZrCg31sqRbc2wasdUOroJAg'
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;
      setState(() {
        isFavorite = results.any((movie) => movie['id'] == mediaId);
      });
      return true;
    } else {
      print(
          'Fallo al cargar favoritos status con status code: ${response.statusCode}');
      isFavorite = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final popularModel =
    ModalRoute.of(context)!.settings.arguments as PopularModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(popularModel.title),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isFavorite = !isFavorite;
              });
              await addFavorite(
                accountId: accountId,
                apiKey: apiKey,
                sessionId: sessionId,
                mediaType: 'movie',
                mediaId: popularModel.id,
                favorite: isFavorite,
              );
            },
            icon:
            isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
            'https://image.tmdb.org/t/p/w500/${popularModel.backdropPath}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          FutureBuilder<List<String>>(
            future: _trailerUrls,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Fallo al cargar los trailers'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No hay trailers disponibles'));
              } else {
                return Column(
                  children: [
                    YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId:
                        snapshot.data![0], // carga el primer trailer
                        flags: YoutubePlayerFlags(
                          autoPlay: false, // se reproduce automaticamente
                          mute: false, //que no tenga sonido
                        ),
                      ),
                      showVideoProgressIndicator: true,
                    ),
                    Expanded(
                      child: Container(
                        color: const Color.fromARGB(38, 0, 0, 0),
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Popularidad: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${popularModel.popularity}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Descripción:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${popularModel.overview}',
                                style: TextStyle(color: Colors.white),
                                softWrap: true,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Creditos:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              FutureBuilder<Credits>(
                                future: _movieCredits,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child: Text(
                                            'Fallo al cargar los créditos'));
                                  } else if (!snapshot.hasData) {
                                    return Center(
                                        child: Text(
                                            'No hay créditos disponibles'));
                                  } else {
                                    final credits = snapshot.data!;
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cast:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        ...credits.cast.map((personCredits) {
                                          return Text(
                                            '${personCredits.originalName} - ${personCredits.knownForDepartment}',
                                            style:
                                            TextStyle(color: Colors.white),
                                          );
                                        }).toList(),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          'Equipo detras de camara:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        ...credits.crew.map((personCredits) {
                                          return Text(
                                            '${personCredits.originalName} - ${personCredits.knownForDepartment}',
                                            style:
                                            TextStyle(color: Colors.white),
                                          );
                                        }
                                        ).toList(),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}