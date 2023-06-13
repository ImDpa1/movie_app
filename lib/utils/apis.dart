class Apis {
  static const String imgHeader = "https://image.tmdb.org/t/p/w500";
  static const String url1stPart = "https://api.themoviedb.org/3";
  static const String urlLastPart = "?api_key=9f9c5bb2ee58e800521bad13af1683a4";

  static const String movie = url1stPart + "/movie/";
  static const String tv = url1stPart + "/tv/";
  static const String celebs = url1stPart + "/person/";


  static const String getMovie = movie + "now_playing" + urlLastPart;
  static const String getTvShow = tv + "on_the_air" + urlLastPart;
  static const String getCelebs = celebs + "popular" + urlLastPart;
  static const String imgLastUrl = "/images" + urlLastPart;
  static const String creditLastUrl = "/credits" + urlLastPart;
}