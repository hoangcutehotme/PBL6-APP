class LocationCoordinate {
  List<dynamic> coordinates;

  LocationCoordinate({
    required this.coordinates,
  });

  factory LocationCoordinate.fromJson(Map<String, dynamic> json) =>
      LocationCoordinate(
        coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from((coordinates ?? []).map((x) => x)),
      };
}
