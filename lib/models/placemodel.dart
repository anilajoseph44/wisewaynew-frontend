// To parse this JSON data, do
//
//     final placeList = placeListFromJson(jsonString);

import 'dart:convert';

List<PlaceList> placeListFromJson(String str) => List<PlaceList>.from(json.decode(str).map((x) => PlaceList.fromJson(x)));

String placeListToJson(List<PlaceList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaceList {
  Location location;
  String id;
  String name;
  String details;
  String city;
  String country;
  String state;
  String postalCode;
  double starRating;
  String picture;
  List<AvailableWeekDay> availableWeekDays;
  int v;

  PlaceList({
    required this.location,
    required this.id,
    required this.name,
    required this.details,
    required this.city,
    required this.country,
    required this.state,
    required this.postalCode,
    required this.starRating,
    required this.picture,
    required this.availableWeekDays,
    required this.v,
  });

  factory PlaceList.fromJson(Map<String, dynamic> json) => PlaceList(
    location: Location.fromJson(json["location"]),
    id: json["_id"],
    name: json["name"],
    details: json["details"],
    city: json["city"],
    country: json["Country"],
    state: json["State"],
    postalCode: json["PostalCode"],
    starRating: json["starRating"]?.toDouble(),
    picture: json["picture"],
    availableWeekDays: List<AvailableWeekDay>.from(json["availableWeekDays"].map((x) => AvailableWeekDay.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "_id": id,
    "name": name,
    "details": details,
    "city": city,
    "Country": country,
    "State": state,
    "PostalCode": postalCode,
    "starRating": starRating,
    "picture": picture,
    "availableWeekDays": List<dynamic>.from(availableWeekDays.map((x) => x.toJson())),
    "__v": v,
  };
}

class AvailableWeekDay {
  String dayOfWeek;
  OpenTime openTime;
  CloseTime closeTime;
  String id;

  AvailableWeekDay({
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    required this.id,
  });

  factory AvailableWeekDay.fromJson(Map<String, dynamic> json) => AvailableWeekDay(
    dayOfWeek: json["dayOfWeek"],
    openTime: openTimeValues.map[json["openTime"]]!,
    closeTime: closeTimeValues.map[json["closeTime"]]!,
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "dayOfWeek": dayOfWeek,
    "openTime": openTimeValues.reverse[openTime],
    "closeTime": closeTimeValues.reverse[closeTime],
    "_id": id,
  };
}

enum CloseTime {
  THE_0500_PM,
  THE_0600_PM
}

final closeTimeValues = EnumValues({
  "05:00 PM": CloseTime.THE_0500_PM,
  "06:00 PM": CloseTime.THE_0600_PM
});

enum OpenTime {
  THE_0800_AM
}

final openTimeValues = EnumValues({
  "08:00 AM": OpenTime.THE_0800_AM
});

class Location {
  List<double> coordinates;
  String type;

  Location({
    required this.coordinates,
    required this.type,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "type": type,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
