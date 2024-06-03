//Clase para almacenar personas que salen en los creditos
class PersonCredits {
  final int id;
  final String knownForDepartment;
  final String originalName;

  PersonCredits({
    required this.id,
    required this.knownForDepartment,
    required this.originalName,
  });

  factory PersonCredits.fromJson(Map<String, dynamic> json) {
    return PersonCredits(
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      originalName: json['original_name'],
    );
  }
}