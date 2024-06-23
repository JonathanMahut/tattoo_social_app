class Tattoo {
  final String id;
  final String artistId;
  final String imageUrl;
  final String style;
  final String description;

  Tattoo(
      {required this.id,
      required this.artistId,
      required this.imageUrl,
      required this.style,
      required this.description});

  factory Tattoo.fromJson(Map<String, dynamic> json) {
    return Tattoo(
      id: json['id'],
      artistId: json['artistId'],
      imageUrl: json['imageUrl'],
      style: json['style'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artistId': artistId,
      'imageUrl': imageUrl,
      'style': style,
      'description': description,
    };
  }
}
