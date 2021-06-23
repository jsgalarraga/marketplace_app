import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  num price;
  String imageRoute;
  String? imageUrl;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageRoute,
    this.imageUrl,
  });

  Product copyWith({
    String? id,
    String? name,
    num? price,
    String? imageRoute,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageRoute: imageRoute ?? this.imageRoute,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageRoute': imageRoute,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imageRoute: map['imageRoute'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  factory Product.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return Product(
      name: data['name'],
      price: data['price'],
      imageRoute: data['image'],
      id: snap.id,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, imageRoute: $imageRoute, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.imageRoute == imageRoute &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        imageRoute.hashCode ^
        imageUrl.hashCode;
  }
}
