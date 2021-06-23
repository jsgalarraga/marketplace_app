import 'package:flutter/material.dart';
import 'package:marketplace_app/constants/strings.dart';
import 'package:marketplace_app/ui/views/cart_view.dart';
import 'package:marketplace_app/ui/views/products_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (context) => ProductsView());
      case CART_ROUTE:
        return MaterialPageRoute(builder: (context) => CartView());
      default:
        return MaterialPageRoute(builder: (context) => ProductsView());
    }
  }
}
