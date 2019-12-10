import 'dart:convert';

class Task {

  Task({
    this.id,
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
    this.hired,
  });

  String id;
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
  String hired; // delete

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
    String id,
    String hired,
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
      id: id ?? this.id,
      hired: hired ?? this.hired,
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
      'id': id,
      'hired': hired,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Task(
      hourly: map['hourly'],
      title: map['title'],
      description: map['description'],
      payment: map['payment'],
      date: DateTime.fromMicrosecondsSinceEpoch(
          map['date'].microsecondsSinceEpoch),
      // new DateTime.fromMillisecondsSinceEpoch( * 1000),
      placeId: map['place_id'],
      creator: map['creator'],
      formattedAddress: map['formattedAddress'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      id: map['id'],
      hired: map['hired'],
    );
  }

  String toJson() => json.encode(toMap());

  static Task fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task id: $id, hourly: $hourly, title: $title, description: $description, payment: $payment, date: $date, placeId: $placeId, creator: $creator, formattedAddress: $formattedAddress, latitude: $latitude, longitude: $longitude';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Task &&
        o.id == id &&
        o.hourly == hourly &&
        o.title == title &&
        o.description == description &&
        o.payment == payment &&
        o.date == date &&
        o.placeId == placeId &&
        o.creator == creator &&
        o.formattedAddress == formattedAddress &&
        o.latitude == latitude &&
        o.longitude == longitude &&
        o.hired == hired;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    hourly.hashCode ^
    title.hashCode ^
    description.hashCode ^
    payment.hashCode ^
    date.hashCode ^
    placeId.hashCode ^
    creator.hashCode ^
    formattedAddress.hashCode ^
    latitude.hashCode ^
    longitude.hashCode ^
    hired.hashCode;
  }
}