import 'package:bloc/bloc.dart';
import 'package:marketplace_app/data/models/product.dart';
import 'package:marketplace_app/data/repository.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final Repository repository;

  ProductsCubit({required this.repository}) : super(ProductsInitial());

  void getProducts() {
    // Updates the productList when a change occurrs in the database
    repository.getProducts().listen((productList) {
      // Updates the product imageUrl
      productList.forEach((product) async {
        product.imageUrl =
            await repository.getProductImageUrl(product.imageRoute);
        emit(ProductsUpdated(productList: productList));
      });
    });
  }
}
