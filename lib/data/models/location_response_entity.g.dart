// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponse _$LocationResponseFromJson(
        Map<String, dynamic> json) =>
    LocationResponse(
      json['constants'] == null
          ? null
          : Constants.fromJson(
              json['constants'] as Map<String, dynamic>),
      (json['bounds'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Bounds.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      (json['locations'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Location.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationResponseToJson(
        LocationResponse instance) =>
    <String, dynamic>{
      'constants': instance.constants,
      'bounds': instance.bounds,
      'locations': instance.locations,
    };

Constants _$ConstantsFromJson(
        Map<String, dynamic> json) =>
    Constants(
      json['getDirection'] as String?,
      json['findOutMore'] as String?,
      json['contactUs'] as String?,
      json['mailUs'] as String?,
      json['defaultDropdownValue'] as String?,
    );

Map<String, dynamic> _$ConstantsToJson(
        Constants instance) =>
    <String, dynamic>{
      'getDirection': instance.getDirection,
      'findOutMore': instance.findOutMore,
      'contactUs': instance.contactUs,
      'mailUs': instance.mailUs,
      'defaultDropdownValue': instance.defaultDropdownValue,
    };

Bounds _$BoundsFromJson(
        Map<String, dynamic> json) =>
    Bounds(
      (json['breakPoint'] as num?)?.toInt(),
      (json['zoom'] as num?)?.toInt(),
      json['bounds'] == null
          ? null
          : BoundsDetails.fromJson(
              json['bounds'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoundsToJson(
        Bounds instance) =>
    <String, dynamic>{
      'breakPoint': instance.breakPoint,
      'zoom': instance.zoom,
      'bounds': instance.bounds,
    };

BoundsDetails _$BoundsDetailsFromJson(
        Map<String, dynamic> json) =>
    BoundsDetails(
      (json['south'] as num?)?.toDouble(),
      (json['west'] as num?)?.toInt(),
      (json['north'] as num?)?.toDouble(),
      (json['east'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BoundsDetailsToJson(
        BoundsDetails instance) =>
    <String, dynamic>{
      'south': instance.south,
      'west': instance.west,
      'north': instance.north,
      'east': instance.east,
    };

Location _$LocationFromJson(
        Map<String, dynamic> json) =>
    Location(
      json['area'] as String?,
      json['geo'] as String?,
      json['location'] as String?,
      (json['officeType'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      json['additionalInfo'] as List<dynamic>?,
      json['address'] as String?,
      json['phone'] as String?,
      json['geometry'] == null
          ? null
          : Geometry.fromJson(
              json['geometry'] as Map<String, dynamic>),
      json['email'] as String?,
      json['keywords'] as List<dynamic>?,
      (json['websites'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Websites.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      json['id'] as String?,
    );

Map<String, dynamic> _$LocationToJson(
        Location instance) =>
    <String, dynamic>{
      'area': instance.area,
      'geo': instance.geo,
      'location': instance.location,
      'officeType': instance.officeType,
      'additionalInfo': instance.additionalInfo,
      'address': instance.address,
      'phone': instance.phone,
      'geometry': instance.geometry,
      'email': instance.email,
      'keywords': instance.keywords,
      'websites': instance.websites,
      'id': instance.id,
    };

Geometry
    _$GeometryFromJson(
            Map<String, dynamic> json) =>
        Geometry(
          (json['lat'] as num?)?.toDouble(),
          (json['lng'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$GeometryToJson(
        Geometry instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Websites
    _$WebsitesFromJson(
            Map<String, dynamic> json) =>
        Websites(
          json['name'] as String?,
          json['url'] as String?,
        );

Map<String, dynamic> _$WebsitesToJson(
        Websites instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
