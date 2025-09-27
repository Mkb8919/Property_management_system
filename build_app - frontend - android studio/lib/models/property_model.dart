class Property {
  String id;
  String title;
  String description;
  String address;
  double price;
  String type; // apartment, villa, plot
  String status; // available, sold
  List<String> images;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.price,
    required this.type,
    required this.status,
    required this.images,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json['_id'],
    title: json['title'],
    description: json['description'],
    address: json['address'],
    price: json['price'].toDouble(),
    type: json['type'],
    status: json['status'],
    images: List<String>.from(json['images']),
  );
}
