import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  num price;
  String imageUrl;
  String id;
  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.id,
  });

  Product copyWith({
    String? name,
    double? price,
    String? imageUrl,
    String? id,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      id: map['id'],
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
      imageUrl: data['image'],
      id: snap.id,
    );
  }

  @override
  String toString() {
    return 'Product(name: $name, price: $price, imageUrl: $imageUrl, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ price.hashCode ^ imageUrl.hashCode ^ id.hashCode;
  }
}
