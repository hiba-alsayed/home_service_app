// service_provider_model.dart
class ServiceProvider {
  dynamic id;
  dynamic providerName;
  dynamic providerEmail;
  dynamic providerCity;
  dynamic image;
  dynamic service;
  dynamic yearsExperience;
  dynamic description;
  dynamic phone;

  ServiceProvider({
    required this.id,
    required this.providerName,
    required this.providerEmail,
    required this.providerCity,
    required this.image,
    required this.service,
    required this.yearsExperience,
    required this.description,
    required this.phone,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id'],
      providerName: json['provider']['name'],
      providerEmail: json['provider']['email'],
      providerCity: json['provider']['city'],
      image: json['image'],
      service: json['service'],
      yearsExperience: json['years_experience'],
      description: json['description'],
      phone: json['phone'],
    );
  }
}
