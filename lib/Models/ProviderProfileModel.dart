class ProviderProfileModel {
  dynamic profileId;
  dynamic providerId;
  dynamic name;
  dynamic image;
  dynamic service;
  dynamic yearsExperience;
  dynamic description;
  dynamic phone;

  ProviderProfileModel({
    required this.profileId,
    required this.providerId,
    required this.name,
    required this.image,
    required this.service,
    required this.yearsExperience,
    required this.description,
    required this.phone,
  });

  factory ProviderProfileModel.fromJson(Map<String, dynamic> json) {
    return ProviderProfileModel(
      profileId: json['profile_id'],
      providerId: json['provider_id'],
      name: json['Name'],
      image: json['image'],
      service: json['service'],
      yearsExperience: json['years_experience'],
      description: json['description '].trim(),
      phone: json['phone'],
    );
  }
}
