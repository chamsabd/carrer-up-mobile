class Img {
  String url;

  Img({required this.url});

  factory Img.fromJsonimg(Map<String, dynamic> json) {
    return Img(
      url: json["url"]
      );
  }
}
