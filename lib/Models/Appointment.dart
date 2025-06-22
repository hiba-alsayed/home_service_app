class Appointment {
  dynamic id;
  dynamic provider;
  dynamic status;
  dynamic date;
  dynamic hour;
  dynamic city;
  dynamic description;

  Appointment({
    required this.id,
    required this.provider,
    required this.status,
    required this.date,
    required this.hour,
    required this.city,
    required this.description,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      provider: json['provider'],
      status: json['status'],
      date: json['date'],
      hour: json['hour'],
      city: json['city'],
      description: json['description'],
    );
  }
}
