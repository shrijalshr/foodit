import 'package:latlong2/latlong.dart';

class MapModel {
  String? sId;
  Bounds? bounds;
  String? destination;
  late List<Cordinate> route;
  late Cordinate center;
  int? iV;

  MapModel(
      {this.sId, this.bounds, this.destination, required this.route, this.iV,required this.center});

  MapModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bounds =
        json['bounds'] != null ? new Bounds.fromJson(json['bounds']) : null;
    destination = json['destination'];
    if (json['route'] != null) {
      route = <Cordinate>[];
      json['route'].forEach((v) {
        route!.add(new Cordinate.fromJson(v));
      });
    } else {
      route = [];
    }

    if (json['center'] != null) {
      center = Cordinate.fromJson(json['center']);
    } else {
      center = Cordinate(lat: 27.700769, lng: 85.300140);
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.bounds != null) {
      data['bounds'] = this.bounds!.toJson();
    }
    data['destination'] = this.destination;
    data['center'] = this.center.toJson();
    if (this.route != null) {
      data['route'] = this.route!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Bounds {
  Cordinate? sSouthWest;
  Cordinate? sNorthEast;
  String? sId;

  Bounds({this.sSouthWest, this.sNorthEast, this.sId});

  Bounds.fromJson(Map<String, dynamic> json) {
    sSouthWest = json['_southWest'] != null
        ? new Cordinate.fromJson(json['_southWest'])
        : null;
    sNorthEast = json['_northEast'] != null
        ? new Cordinate.fromJson(json['_northEast'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sSouthWest != null) {
      data['_southWest'] = this.sSouthWest!.toJson();
    }
    if (this.sNorthEast != null) {
      data['_northEast'] = this.sNorthEast!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Cordinate {
  late double lat;
  late double lng;

  Cordinate({required this.lat, required this.lng});

  Cordinate.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] ?? 0;
    lng = json['lng'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
