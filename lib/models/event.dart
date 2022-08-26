// Data model for mapping response object
import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
    required this.events,
    required this.meta,
  });

  List<EventElement> events;
  Meta meta;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        events: List<EventElement>.from(
            json["events"].map((x) => EventElement.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class EventElement {
  EventElement({
    required this.type,
    required this.id,
    required this.shortTitle,
    this.url,
    this.score,
    required this.announceDate,
    required this.createdAt,
    required this.title,
    this.popularity,
    this.description,
    required this.status,
  });

  String type;
  int id;
  String shortTitle;
  String? url;
  double? score;
  DateTime announceDate;
  DateTime createdAt;
  String title;
  double? popularity;
  String? description;
  String status;

  factory EventElement.fromJson(Map<String, dynamic> json) => EventElement(
        type: json["type"],
        id: json["id"],
        shortTitle: json["short_title"],
        url: json["url"],
        score: json["score"].toDouble(),
        announceDate: DateTime.parse(json["announce_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        title: json["title"],
        popularity: json["popularity"].toDouble(),
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "short_title": shortTitle,
        "url": url,
        "score": score,
        "announce_date": announceDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "title": title,
        "popularity": popularity,
        "description": description,
        "status": status,
      };
}

class Meta {
  Meta({
    required this.total,
    required this.took,
    required this.page,
    required this.perPage,
    this.geolocation,
  });

  int total;
  int took;
  int page;
  int perPage;
  dynamic? geolocation;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        took: json["took"],
        page: json["page"],
        perPage: json["per_page"],
        geolocation: json["geolocation"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "took": took,
        "page": page,
        "per_page": perPage,
        "geolocation": geolocation,
      };
}
