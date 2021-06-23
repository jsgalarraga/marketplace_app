import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:marketplace_app/data/models/product.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<List<Product>> getProducts() {
    // Gets the list of products stored on the firestore database
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = firestore
        .collection('products')
        .orderBy('price', descending: true)
        .snapshots();

    Stream<List<Product>> productList = snapshots.map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList());

    return productList;
  }

  Future<String> getProductImageUrl(String route) async {
    // Retrieves the downlad url of an image having its relative route
    return await storage.ref().child('products').child(route).getDownloadURL();
  }
}
