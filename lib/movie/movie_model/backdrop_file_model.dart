class ImageModel {
  List<Backdrops>? backdrops;
  List<String>? filePath;
  int? id;


  ImageModel({this.backdrops, this.id, this.filePath});
  ImageModel.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrops = <Backdrops>[];
      json['backdrops'].forEach((v) {
        backdrops!.add(new Backdrops.fromJson(v));
      });
    }
    if(json['profiles'] != null){
      filePath = <String>[];
      json["profiles"].forEach((value){
        if (value["file_path"] != null) {
          filePath!.add(value["file_path"]);
        }
      });
    }

    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.backdrops != null) {
      data['backdrops'] = this.backdrops!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}
class Backdrops {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  dynamic voteAverage;
  int? voteCount;
  int? width;

  Backdrops(
      {this.aspectRatio,
        this.height,
        this.iso6391,
        this.filePath,
        this.voteAverage,
        this.voteCount,
        this.width});

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_ratio'] = this.aspectRatio;
    data['height'] = this.height;
    data['iso_639_1'] = this.iso6391;
    data['file_path'] = this.filePath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['width'] = this.width;
    return data;
  }
}
