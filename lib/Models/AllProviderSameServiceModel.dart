// models/all_provider_same_service_model.dart
class AllProviderSameServiceModel {
  dynamic providerId;
  dynamic id;
  dynamic image;
  dynamic name;
  dynamic yearsOfExperience;
  dynamic location;
  double rating;
  dynamic phone;
  dynamic description;

  AllProviderSameServiceModel({
    required this.providerId,
    required this.id,
    required this.image,
    required this.name,
    required this.yearsOfExperience,
    required this.location,
    required this.rating,
    required this.phone,
    required this.description
  });

  factory AllProviderSameServiceModel.fromJson(Map<String, dynamic> json) {
    return AllProviderSameServiceModel(
      phone: json['phone'] ,
      description: json['description'] ,
      providerId: json['provider']['provider_id'],
      id: json['id'],
      image: json['image'],
      name: json['provider']['name'],
      yearsOfExperience: json['years_experience'],
      location: json['provider']['city'],
      rating: _calculateAverageRating(json['provider']['rating']),
    );
  }

  static double _calculateAverageRating(dynamic ratingData) {
    if (ratingData is List && ratingData.isNotEmpty) {
      double total = 0.0;
      int count = 0;
      for (var rating in ratingData) {
        if (rating is num) {
          total += rating.toDouble();
          count++;
        }
      }
      return count > 0 ? total / count : 0.0;
    }
    return 0.0;
  }
}

// models/provider_in_my_city_model.dart
// class ProviderInMyCityModel {
//   dynamic providerId;
//   dynamic name;
//   dynamic location;
//   dynamic yearsOfExperience;
//   double rating;
//   dynamic image;
//
//   ProviderInMyCityModel({
//     required this.providerId,
//     required this.name,
//     required this.location,
//     required this.yearsOfExperience,
//     required this.rating,
//     required this.image,
//   });
//
//   factory ProviderInMyCityModel.fromJson(Map<String, dynamic> json) {
//     return ProviderInMyCityModel(
//       providerId: json['provider_id'],
//       name: json['provider']['name'],
//       location: json['provider']['city'],
//       yearsOfExperience: json['years_experience'],
//       rating: _calculateAverageRating(json['rating']),
//       image: json['image'] ?? '', // Provide a default value if null
//     );
//   }
//
//   static double _calculateAverageRating(dynamic ratingData) {
//     if (ratingData is List && ratingData.isNotEmpty) {
//       double total = 0.0;
//       int count = 0;
//       for (var rating in ratingData) {
//         if (rating is num) {
//           total += rating.toDouble();
//           count++;
//         }
//       }
//       return count > 0 ? total / count : 0.0;
//     }
//     return 0.0;
//   }
// }
