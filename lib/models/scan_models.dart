import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    ScanModel({
        this.id,
        this.type,
        required this.value,
    }) {
      if (this.value.contains('http')) {
        this.type = 'http';
      } else {
        this.type = 'geo';
      }
    }

    int? id;
    String? type;
    String value;

    LatLng getLatLng() {
      final latLng = this.value.replaceFirst('geo:', '').split(',');
      final lat    = double.parse(latLng[0]);
      final lon    = double.parse(latLng[1]);
      
      return LatLng(lat, lon);
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id:    json["id"],
        type:  json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id":    id,
        "type":  type,
        "value": value,
    };
}
