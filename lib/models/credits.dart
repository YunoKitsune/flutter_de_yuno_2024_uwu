import 'package:tap_2024_yuno_uwu/models/person_credits.dart';

//Clase para almacenar creditos de una película (con personas)
class Credits {
  final int id;
  final List<PersonCredits> cast;
  final List<PersonCredits> crew;

  Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory Credits.fromJson(Map<String, dynamic> json) {
    var castList = json['cast'] as List;
    var crewList = json['crew'] as List;

    List<PersonCredits> cast = castList.map((i) => PersonCredits.fromJson(i)).toList();
    List<PersonCredits> crew = crewList.map((i) => PersonCredits.fromJson(i)).toList();

    return Credits(
      id: json['id'],
      cast: cast,
      crew: crew,
    );
  }
}