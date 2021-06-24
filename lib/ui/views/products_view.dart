import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_app/constants/strings.dart';
import 'package:marketplace_app/cubit/cart_cubit.dart';
import 'package:marketplace_app/cubit/products_cubit.dart';
import 'package:marketplace_app/data/models/product.dart';
import 'package:marketplace_app/ui/styles/text_button.dart';

class ProductsView extends StatelessWidget {
  // Main page with the list of products in the marketplace
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
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(product: products[index]);
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

class ProductCard extends StatelessWidget {
  // Widget to show name and image of a product and add it to the cart
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ProductImage(url: product.imageUrl),
          Expanded(
            child: Center(
              child: Text(
                '${product.name}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () {
                  BlocProvider.of<CartCubit>(context).addProduct(product);
                },
                child: Text('Add to cart'),
                style: flatButtonStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  // Widget to show the image of a product having its download url
  final String? url;
  final Radius imageRadius = const Radius.circular(5.0);

  const ProductImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return ClipRRect(
        borderRadius:
            BorderRadius.only(topLeft: imageRadius, topRight: imageRadius),
        child: AspectRatio(
          aspectRatio: 1,
          child: FittedBox(
            child: Image.network(url!),
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
          ),
        ),
      );
    }
    return Center(child: CircularProgressIndicator());
  }
}
