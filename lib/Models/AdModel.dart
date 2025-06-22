class AdModel {
  final int id;
  final String provider;
  final String startDate;
  final String endDate;
  final String city;
  final String service;
  final int phone;
  final int yearsExperience;
  final String description;

  AdModel({
    required this.id,
    required this.provider,
    required this.startDate,
    required this.endDate,
    required this.city,
    required this.service,
    required this.phone,
    required this.yearsExperience,
    required this.description,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      provider: json['provider'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      city: json['city'],
      service: json['service'],
      phone: json['phone'],
      yearsExperience: json['years_Exp'],
      description: json['description'],
    );
  }
}
