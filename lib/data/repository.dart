import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace_app/data/firebase_service.dart';
import 'package:marketplace_app/data/models/product.dart';

class Repository {
  final FirebaseService networkService = FirebaseService();

  Stream<List<Product>> getProducts() {
    return networkService.getProducts();
  }
}
