import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace_app/data/models/product.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        firestore.collection('products').orderBy('price').snapshots();

    Stream<List<Product>> productList = snapshots.map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList());

    return productList;
  }
}
