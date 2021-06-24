import 'package:marketplace_app/data/firebase_service.dart';
import 'package:marketplace_app/data/models/cart_item.dart';
import 'package:marketplace_app/data/models/product.dart';

class Repository {
  final FirebaseService networkService = FirebaseService();
  // Decided to store the cart locally in a variable because
  // there is no need to persist it between sessions. Possible upgrade
  final List<CartItem> cart = <CartItem>[];

  Stream<List<Product>> getProducts() {
    return networkService.getProducts();
  }

  Future<String> getProductImageUrl(String route) async {
    return networkService.getProductImageUrl(route);
  }

  List<CartItem> getCart() => cart;

  void addProductToCart(Product product) {
    cart.add(CartItem(product: product, quantity: 1));
  }

  void removeProductFromCart(Product product) {
    cart.removeWhere((item) => item.product == product);
  }

  bool cartCheckout() {
    // Mocked success when checking out
    return true;
  }

  void emptyCart() {
    cart.removeWhere((_) => true);
  }
}
