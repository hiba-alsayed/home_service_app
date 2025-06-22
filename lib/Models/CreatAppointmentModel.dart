class AppointmentModel {
  final String date;
  final String hours;
  final String description;

  AppointmentModel({
    required this.date,
    required this.hours,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'hours': hours,
      'description': description,
    };
  }
}
