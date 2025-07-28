import 'dart:convert';

Trip tripFromJson(String str) => Trip.fromJson(json.decode(str));

String tripToJson(Trip data) => json.encode(data.toJson());

class Trip {
  int id;
  String name;
  String description;
  String companied;
  String fotoPath;
  double latitude;
  double longitude;

  Trip({
    required this.id,
    required this.name,
    required this.description,
    required this.companied,
    required this.fotoPath,
    required this.latitude,
    required this.longitude,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    companied: json["companied"],
    fotoPath: json["fotoPath"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "companied": companied,
    "fotoPath": fotoPath,
    "latitude": latitude,
    "longitude": longitude,
  };
}
