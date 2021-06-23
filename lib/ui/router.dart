import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_app/constants/strings.dart';
import 'package:marketplace_app/cubit/products_cubit.dart';
import 'package:marketplace_app/data/repository.dart';
import 'package:marketplace_app/ui/views/cart_view.dart';
import 'package:marketplace_app/ui/views/products_view.dart';

class AppRouter {
  final Repository repository = Repository();

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_ROUTE:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProductsCubit(repository: repository),
            child: ProductsView(),
          ),
        );
      case CART_ROUTE:
        return MaterialPageRoute(builder: (context) => CartView());
      default:
        return MaterialPageRoute(builder: (context) => ProductsView());
    }
  }
}
