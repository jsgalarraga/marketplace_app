import 'package:flutter/material.dart';
import 'package:marketplace_app/constants/strings.dart';

class ProductsView extends StatefulWidget {
  ProductsView({Key? key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  void _goToCart() {
    Navigator.pushNamed(context, CART_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
      ),
      body: Center(
        child: Text('Products page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCart,
        tooltip: 'Shopping cart',
        child: Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
