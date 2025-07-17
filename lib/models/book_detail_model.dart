import 'dart:convert';

BookDetailModel bookDetailModelFromJson(String str) => BookDetailModel.fromJson(json.decode(str));

String bookDetailModelToJson(BookDetailModel data) => json.encode(data.toJson());

class BookDetailModel {
  String? description;
  String? title;
  String? publishDate;

  BookDetailModel({
    this.description,
    this.title,
    this.publishDate,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) => BookDetailModel(
        description: json["description"] is String
            ? json["description"]
            : (json["description"] is Map<String, dynamic> && json["description"]["value"] != null)
                ? json["description"]["value"]
                : null,
        title: json["title"],
        publishDate: json["publish_date"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "title": title,
        "publish_date": publishDate,
      };
}

class Contributor {
  String? name;
  String? role;

  Contributor({
    this.name,
    this.role,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) => Contributor(
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
      };
}

class Created {
  String? type;
  DateTime? value;

  Created({
    this.type,
    this.value,
  });

  factory Created.fromJson(Map<String, dynamic> json) => Created(
        type: json["type"],
        value: json["value"] == null ? null : DateTime.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value?.toIso8601String(),
      };
}

class Identifiers {
  List<String>? goodreads;
  List<String>? librivox;

  Identifiers({
    this.goodreads,
    this.librivox,
  });

  factory Identifiers.fromJson(Map<String, dynamic> json) => Identifiers(
        goodreads: json["goodreads"] == null ? [] : List<String>.from(json["goodreads"]!.map((x) => x)),
        librivox: json["librivox"] == null ? [] : List<String>.from(json["librivox"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "goodreads": goodreads == null ? [] : List<dynamic>.from(goodreads!.map((x) => x)),
        "librivox": librivox == null ? [] : List<dynamic>.from(librivox!.map((x) => x)),
      };
}
