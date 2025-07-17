import 'dart:convert';

List<SearchedBookModel> searchedBookModelFromJson(String str) => List<SearchedBookModel>.from(json.decode(str).map((x) => SearchedBookModel.fromJson(x)));

String searchedBookModelToJson(List<SearchedBookModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchedBookModel {
  List<String>? authorKey;
  List<String>? authorName;
  String? coverEditionKey;
  int? coverI;
  String? ebookAccess;
  int? editionCount;
  int? firstPublishYear;
  bool? hasFulltext;
  List<String>? ia;
  String? iaCollectionS;
  String? key;
  List<String>? language;
  String? lendingEditionS;
  String? lendingIdentifierS;
  bool? publicScanB;
  String? title;
  List<String>? idStandardEbooks;
  List<String>? idLibrivox;
  List<String>? idProjectGutenberg;

  SearchedBookModel({
    this.authorKey,
    this.authorName,
    this.coverEditionKey,
    this.coverI,
    this.ebookAccess,
    this.editionCount,
    this.firstPublishYear,
    this.hasFulltext,
    this.ia,
    this.iaCollectionS,
    this.key,
    this.language,
    this.lendingEditionS,
    this.lendingIdentifierS,
    this.publicScanB,
    this.title,
    this.idStandardEbooks,
    this.idLibrivox,
    this.idProjectGutenberg,
  });

  factory SearchedBookModel.fromJson(Map<String, dynamic> json) => SearchedBookModel(
        authorKey: json["author_key"] == null ? [] : List<String>.from(json["author_key"]!.map((x) => x)),
        authorName: json["author_name"] == null ? [] : List<String>.from(json["author_name"]!.map((x) => x)),
        coverEditionKey: json["cover_edition_key"],
        coverI: json["cover_i"],
        ebookAccess: json["ebook_access"],
        editionCount: json["edition_count"],
        firstPublishYear: json["first_publish_year"],
        hasFulltext: json["has_fulltext"],
        ia: json["ia"] == null ? [] : List<String>.from(json["ia"]!.map((x) => x)),
        iaCollectionS: json["ia_collection_s"],
        key: json["key"],
        language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
        lendingEditionS: json["lending_edition_s"],
        lendingIdentifierS: json["lending_identifier_s"],
        publicScanB: json["public_scan_b"],
        title: json["title"],
        idStandardEbooks: json["id_standard_ebooks"] == null ? [] : List<String>.from(json["id_standard_ebooks"]!.map((x) => x)),
        idLibrivox: json["id_librivox"] == null ? [] : List<String>.from(json["id_librivox"]!.map((x) => x)),
        idProjectGutenberg: json["id_project_gutenberg"] == null ? [] : List<String>.from(json["id_project_gutenberg"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "author_key": authorKey == null ? [] : List<dynamic>.from(authorKey!.map((x) => x)),
        "author_name": authorName == null ? [] : List<dynamic>.from(authorName!.map((x) => x)),
        "cover_edition_key": coverEditionKey,
        "cover_i": coverI,
        "ebook_access": ebookAccess,
        "edition_count": editionCount,
        "first_publish_year": firstPublishYear,
        "has_fulltext": hasFulltext,
        "ia": ia == null ? [] : List<dynamic>.from(ia!.map((x) => x)),
        "ia_collection_s": iaCollectionS,
        "key": key,
        "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
        "lending_edition_s": lendingEditionS,
        "lending_identifier_s": lendingIdentifierS,
        "public_scan_b": publicScanB,
        "title": title,
        "id_standard_ebooks": idStandardEbooks == null ? [] : List<dynamic>.from(idStandardEbooks!.map((x) => x)),
        "id_librivox": idLibrivox == null ? [] : List<dynamic>.from(idLibrivox!.map((x) => x)),
        "id_project_gutenberg": idProjectGutenberg == null ? [] : List<dynamic>.from(idProjectGutenberg!.map((x) => x)),
      };
}
