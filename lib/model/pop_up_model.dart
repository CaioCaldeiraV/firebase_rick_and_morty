class PopUpModel {
  String? title;
  String? body;
  String? url;
  bool? activate;

  PopUpModel({this.title, this.body, this.url, this.activate});

  PopUpModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    url = json['url'];
    activate = json['activate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['url'] = this.url;
    data['activate'] = this.activate;
    return data;
  }
}
