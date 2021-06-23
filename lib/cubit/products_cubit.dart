import 'package:bloc/bloc.dart';
import 'package:marketplace_app/data/models/product.dart';
import 'package:marketplace_app/data/repository.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final Repository repository;

  ProductsCubit({required this.repository}) : super(ProductsInitial());

  void getProducts() {
    repository.getProducts().listen((productList) {
      emit(ProductsUpdated(productList: productList));
    });
  }
}
