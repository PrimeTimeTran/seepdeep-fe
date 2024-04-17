class Badge {
  int? year;
  int? month;
  String? name;
  String? urlImg;

  Badge({
    this.year,
    this.month,
    this.name,
    this.urlImg,
  });

  Badge.fromJson(Map<String, dynamic> json)
      : year = json['year'],
        month = json['month'],
        name = json['name'],
        urlImg = json['urlImg'];

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month,
      'name': name,
      'urlImg': urlImg,
    };
  }
}

class BadgeItem {
  int? month;
  int? year;
  int? userId;
  DateTime? date;
  String? urlImg;

  BadgeItem({
    this.month,
    this.year,
    this.userId,
    this.date,
    this.urlImg,
  });

  BadgeItem.fromJson(Map<String, dynamic> json)
      : month = json['month'],
        year = json['year'],
        userId = json['userId'],
        date = json['date'] != null ? DateTime.parse(json['date']) : null,
        urlImg = json['urlImg'];

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'year': year,
      'userId': userId,
      'date': date?.toIso8601String(),
      'urlImg': urlImg,
    };
  }
}
