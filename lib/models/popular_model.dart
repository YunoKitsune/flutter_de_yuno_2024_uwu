class PopularModel {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  PopularModel({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PopularModel.fromMap(Map<String, dynamic> map){
    //String a = "https://image.tmdb.org/t/p/w500/";
    //if(map['backdrop_path'].){}
    return PopularModel(
      backdropPath: map['backdrop_path'] ?? '', //'https://static.animecorner.me/2021/05/ZSR-07-11.png',
      id: map['id'],  
      originalLanguage: map['original_language'], 
      originalTitle: map['original_title'], 
      overview: map['overview'], 
      popularity: map['popularity'], 
      posterPath: map['poster_path'], 
      releaseDate: map['release_date'], 
      title: map['title'], 
      voteAverage: map['vote_average'], 
      voteCount: map['vote_count'], 
      );
  }

}
