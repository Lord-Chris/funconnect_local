import 'dart:convert';

// {
// "id": "97f8378d-dc84-4ef5-b62e-1f2b2f6ca0fd",
// "user_id": "2d6f63c1-d94c-314e-ba03-921d2647cd93",
// "category_id": "fbdcac67-bc0c-3ee4-8715-2c254f06fb36",
// "title": "Facere qui inventore mollitia voluptas blanditiis quas tenetur minus.",
// "cover": "cover.png",
// "description": "Totam qui similique amet. Voluptatem laboriosam et possimus. Perspiciatis voluptate est nulla. Est qui sed impedit error sint quos.",
// "date": "2011-02-17",
// "time": "05:50:35",
// "seats": 6,
// "price": "21.30",
// "type": "public"
// }

class EventModel {
  final String id;
  final String userId;
  final String catergoryId;
  final String title;
  final String cover;
  final String description;
  final String date;
  final String time;
  final int seats;
  final String price;
  final String type;

  EventModel({
    required this.id,
    required this.userId,
    required this.catergoryId,
    required this.title,
    required this.cover,
    required this.description,
    required this.date,
    required this.time,
    required this.seats,
    required this.price,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'catergory_id': catergoryId,
      'title': title,
      'cover': cover,
      'description': description,
      'date': date,
      'time': time,
      'seats': seats,
      'price': price,
      'type': type,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      userId: map['user_id'],
      catergoryId: map['catergory_id'],
      title: map['title'],
      cover: map['cover'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      seats: map['seats'],
      price: map['price'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));
}
