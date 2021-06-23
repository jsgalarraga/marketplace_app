part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsUpdated extends ProductsState {
  final List<Product> productList;

  ProductsUpdated({required this.productList});
}
