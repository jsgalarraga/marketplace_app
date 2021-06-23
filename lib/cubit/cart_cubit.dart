import 'package:bloc/bloc.dart';
import 'package:marketplace_app/data/models/cart_item.dart';
import 'package:marketplace_app/data/models/product.dart';
import 'package:marketplace_app/data/repository.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Repository repository;

  CartCubit({required this.repository}) : super(CartInitial());

  void getCart() {
    emit(CartUpdated(cart: repository.getCart()));
  }

  void addProduct(Product product) {
    List<CartItem> cart = repository.getCart();
    if (cart.any((item) => item.product == product)) {
      // If the product is already in the cart, increment quantity
      int index = cart.indexWhere((item) => item.product == product);
      cart[index].incrementQuantity();
    } else {
      // Otherwise, add new product to cart
      repository.addProductToCart(product);
    }
    emit(CartUpdated(cart: repository.getCart()));
  }

  void decrementProduct(Product product) {
    // Decrements product quantity by 1
    List<CartItem> cart = repository.getCart();
    int index = cart.indexWhere((item) => item.product == product);
    if (cart[index].decrementQuantity() == 0) {
      // In case quantity is 0, removes product from cart
      removeProduct(product);
    }
    emit(CartUpdated(cart: repository.getCart()));
  }

  void removeProduct(Product product) {
    // Removes the product from the cart
    repository.removeProductFromCart(product);
    emit(CartUpdated(cart: repository.getCart()));
  }
}
