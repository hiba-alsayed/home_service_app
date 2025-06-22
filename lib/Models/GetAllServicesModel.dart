class GetAllServicesModel {
  dynamic id;
  dynamic name;
  dynamic description;
  // dynamic image;

  GetAllServicesModel({
    required this.id,
    required this.name,
    required this.description,
    // required this.image,
  });

  factory GetAllServicesModel.fromJson(Map<String, dynamic> jsonData) {
    return GetAllServicesModel(
      id: jsonData['id'],
      name: jsonData['name'],
      description: jsonData['description'],
      // image: jsonData['image'],
    );
  }
}
