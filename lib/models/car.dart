class Car {
  final String id;
  final String make;
  final String model;
  final int year;

  Car(
      {required this.id,
      required this.make,
      required this.model,
      required this.year});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
    };
  }
}
