import 'dart:convert';

class PostModel {
  final String title;
  final String path;
  final String detail;
  final String lat;
  final String lng;
  PostModel({
    this.title,
    this.path,
    this.detail,
    this.lat,
    this.lng,
  });

  PostModel copyWith({
    String title,
    String path,
    String detail,
    String lat,
    String lng,
  }) {
    return PostModel(
      title: title ?? this.title,
      path: path ?? this.path,
      detail: detail ?? this.detail,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'path': path,
      'detail': detail,
      'lat': lat,
      'lng': lng,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      title: map['title'],
      path: map['path'],
      detail: map['detail'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(title: $title, path: $path, detail: $detail, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PostModel &&
      other.title == title &&
      other.path == path &&
      other.detail == detail &&
      other.lat == lat &&
      other.lng == lng;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      path.hashCode ^
      detail.hashCode ^
      lat.hashCode ^
      lng.hashCode;
  }
}
