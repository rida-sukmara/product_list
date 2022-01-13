import 'package:equatable/equatable.dart';

class Product extends Equatable {
  static const tableName = 'tbl_product';

  final String id;
  final String name;
  final String description;
  final String price;
  final String image;
  final bool isOnWishlist;

  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image,
      this.isOnWishlist = false});

  @override
  List<Object?> get props => [id, name, description, price, image];

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
        isOnWishlist: json['isOnWishlist'] == 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'isOnWishlist': isOnWishlist ? 1 : 0
    };
  }

  static Product copyWith({required Product product, bool isOnWish = false}) {
    return Product(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        image: product.image,
        isOnWishlist: isOnWish);
  }

  @override
  String toString() {
    return """
      {
        id: $id,
        name: $name,
        decription: $description,
        price: $price,
        image: $image,
        isOnWishlist: $isOnWishlist
      }
    """;
  }
}
