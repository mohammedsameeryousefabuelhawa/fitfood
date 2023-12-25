class BannerImagesModel {
  String Id;
  String ImageURL;
  String URL;

  BannerImagesModel({
    required this.Id,
    required this.ImageURL,
    required this.URL,
  });

  factory BannerImagesModel.fromJson(var json) {
    return BannerImagesModel(
      Id: json['Id'],
      ImageURL: json['ImageURL'],
      URL: json['URL'],
    );
  }
}
