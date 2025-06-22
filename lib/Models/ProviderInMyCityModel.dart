class ProviderInMyCityModel {
  dynamic providerId;
  dynamic name;
  dynamic location;
  dynamic yearsOfExperience;
  dynamic rating;
   dynamic image;

  ProviderInMyCityModel({
    required this.providerId,
    required this.name,
    required this.location,
    required this.yearsOfExperience,
    required this.rating,
    required this.image,
  });

  factory ProviderInMyCityModel.fromJson(Map<String, dynamic> json) {
    return ProviderInMyCityModel(
      providerId: json['provider_id'],
      name: json['provider']['name'],
      location: json['provider']['city'],
      yearsOfExperience: json['years_experience'],
      rating: (json['rating'] != null) ? json['rating'].toDouble() : 0,
      image: json['image'] ?? '', // Provide a default value if null
    );
  }
}
