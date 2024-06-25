import 'package:json_annotation/json_annotation.dart';

part 'location_response_entity.g.dart';

@JsonSerializable()
class LocationResponse {
  final Constants? constants;
  final List<Bounds?>? bounds;
  final List<Location?>? locations;

  LocationResponse(this.constants, this.bounds, this.locations);

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LocationResponseToJson(this);
}

@JsonSerializable()
class Constants {
  final String? getDirection;
  final String? findOutMore;
  final String? contactUs;
  final String? mailUs;
  final String? defaultDropdownValue;

  Constants(this.getDirection, this.findOutMore, this.contactUs, this.mailUs,
      this.defaultDropdownValue);

  factory Constants.fromJson(Map<String, dynamic> json) =>
      _$ConstantsFromJson(json);

  Map<String, dynamic> toJson() => _$ConstantsToJson(this);
}

@JsonSerializable()
class Bounds {
  final int? breakPoint;
  final int? zoom;
  final BoundsDetails? bounds;

  Bounds(this.breakPoint, this.zoom, this.bounds);

  factory Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);

  Map<String, dynamic> toJson() => _$BoundsToJson(this);
}

@JsonSerializable()
class BoundsDetails {
  final double? south;
  final int? west;
  final double? north;
  final int? east;

  BoundsDetails(this.south, this.west, this.north, this.east);

  factory BoundsDetails.fromJson(Map<String, dynamic> json) =>
      _$BoundsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BoundsDetailsToJson(this);
}

@JsonSerializable()
class Location {
  final String? area;
  final String? geo;
  final String? location;
  final List<String?>? officeType;
  final List<dynamic>? additionalInfo;
  final String? address;
  final String? phone;
  final Geometry? geometry;
  final String? email;
  final List<dynamic>? keywords;
  final List<Websites?>? websites;
  final String? id;

  Location(
      this.area,
      this.geo,
      this.location,
      this.officeType,
      this.additionalInfo,
      this.address,
      this.phone,
      this.geometry,
      this.email,
      this.keywords,
      this.websites,
      this.id);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() {
    return area.toString();
  }
}

@JsonSerializable()
class Geometry {
  final double? lat;
  final double? lng;

  Geometry(this.lat, this.lng);

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Websites {
  final String? name;
  final String? url;

  Websites(this.name, this.url);

  factory Websites.fromJson(Map<String, dynamic> json) =>
      _$WebsitesFromJson(json);

  Map<String, dynamic> toJson() => _$WebsitesToJson(this);
}
