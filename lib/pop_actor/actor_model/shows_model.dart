class ShowsModel {
  List<ShowsCast>? cast;
  int? id;

  ShowsModel({this.cast,  this.id});

  ShowsModel.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = <ShowsCast>[];
      json['cast'].forEach((v) {
        cast!.add(new ShowsCast.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cast != null) {
      data['cast'] = this.cast!.map((v) => v.toJson()).toList();
    }

    data['id'] = this.id;
    return data;
  }
}

class ShowsCast {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? character;
  String? creditId;
  int? order;
  String? mediaType;
  List<String>? originCountry;
  String? originalName;
  String? firstAirDate;
  String? name;
  int? episodeCount;

  ShowsCast(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.character,
        this.creditId,
        this.order,
        this.mediaType,
        this.originCountry,
        this.originalName,
        this.firstAirDate,
        this.name,
        this.episodeCount});

  ShowsCast.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    mediaType = json['media_type'];
    // originCountry = json['origin_country'].cast<String>();
    originalName = json['original_name'];
    firstAirDate = json['first_air_date'];
    name = json['name'];
    episodeCount = json['episode_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['character'] = this.character;
    data['credit_id'] = this.creditId;
    data['order'] = this.order;
    data['media_type'] = this.mediaType;
    data['origin_country'] = this.originCountry;
    data['original_name'] = this.originalName;
    data['first_air_date'] = this.firstAirDate;
    data['name'] = this.name;
    data['episode_count'] = this.episodeCount;
    return data;
  }
}