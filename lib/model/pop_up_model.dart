class PopUpModel {
  String? title;
  String? body;
  String? urlImage;
  bool? activate;
  String? urlLink;

  PopUpModel(
      {this.title, this.body, this.urlImage, this.activate, this.urlLink});

  PopUpModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    body = json['body'] ?? "";
    urlImage = json['urlImage'] ?? "";
    activate = json['activate'] ?? false;
    urlLink = json['urlLink'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['urlImage'] = this.urlImage;
    data['activate'] = this.activate;
    data['urlLink'] = this.urlLink;
    return data;
  }
}
