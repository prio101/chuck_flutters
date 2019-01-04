class Chuck {
  final String id;
  final String iconUri;
  final String url;
  final String value;

  Chuck({this.iconUri, this.id, this.url, this.value});

  factory Chuck.fromJson(Map<String, dynamic> json) {
    return Chuck(
      iconUri: json['icon_uri'],
      id: json['id'],
      url: json['url'],
      value: json['value'],
    );
  }
}