

class Location {
    List<dynamic> coordinates;

    Location({
        required this.coordinates,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}
