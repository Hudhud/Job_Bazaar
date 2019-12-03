import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

    Task({
    this.hourly,
    this.title,
    this.description,
    this.payment,
    this.date,
    this.placeId,
    this.creator,
    this.formattedAddress,
    this.latitude,
    this.longitude,
  });

  bool hourly;
  String title;
  String description;
  double payment;
  DateTime date;
  String placeId;
  String creator;
  String formattedAddress;
  double latitude;
  double longitude;


  Task copyWith({
    bool hourly,
    String title,
    String description,
    double payment,
    DateTime date,
    String placeId,
    String creator,
    String formattedAddress,
    double latitude,
    double longitude,
  }) {
    return Task(
      hourly: hourly ?? this.hourly,
      title: title ?? this.title,
      description: description ?? this.description,
      payment: payment ?? this.payment,
      date: date ?? this.date,
      placeId: placeId ?? this.placeId,
      creator: creator ?? this.creator,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hourly': hourly,
      'title': title,
      'description': description,
      'payment': payment,
      'date': date.toString(),
      'placeId': placeId,
      'creator': creator,
      'formattedAddress': formattedAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Task(
      hourly: map['hourly'],
      title: map['title'],
      description: map['description'],
      payment: map['payment'],
      date: DateTime.fromMicrosecondsSinceEpoch(map['date'].microsecondsSinceEpoch),// new DateTime.fromMillisecondsSinceEpoch( * 1000),
      placeId: map['place_id'],
      creator: map['creator'],
      formattedAddress: map['formattedAddress'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  static Task fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task hourly: $hourly, title: $title, description: $description, payment: $payment, date: $date, placeId: $placeId, creator: $creator, formattedAddress: $formattedAddress, latitude: $latitude, longitude: $longitude';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Task &&
      o.hourly == hourly &&
      o.title == title &&
      o.description == description &&
      o.payment == payment &&
      o.date == date &&
      o.placeId == placeId &&
      o.creator == creator &&
      o.formattedAddress == formattedAddress &&
      o.latitude == latitude &&
      o.longitude == longitude;
  }

  @override
  int get hashCode {
    return hourly.hashCode ^
      title.hashCode ^
      description.hashCode ^
      payment.hashCode ^
      date.hashCode ^
      placeId.hashCode ^
      creator.hashCode ^
      formattedAddress.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
  }
}