import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_app/constants/strings.dart';
import 'package:marketplace_app/cubit/products_cubit.dart';
import 'package:marketplace_app/data/models/product.dart';

class ProductsView extends StatelessWidget {
  ProductsView({Key? key}) : super(key: key);

  void _goToCart(BuildContext context) {
    Navigator.pushNamed(context, CART_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (!(state is ProductsUpdated)) {
            return Center(child: CircularProgressIndicator());
          }

          final List<Product> products = state.productList;

          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text('${products[index].name}'),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCart(context),
        tooltip: 'Shopping cart',
        child: Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
