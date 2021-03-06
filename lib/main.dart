import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_app/cubit/cart_cubit.dart';
import 'package:marketplace_app/cubit/checkout_cubit.dart';
import 'package:marketplace_app/cubit/products_cubit.dart';
import 'package:marketplace_app/data/repository.dart';
import 'package:marketplace_app/ui/router.dart';
import 'package:marketplace_app/ui/styles/colors.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  // Root widget in charge of initializing Firebase and handling its connection
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Center(
                child: Text('A problem has occurred when initializing the app'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MarketplaceApp(router: AppRouter());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class MarketplaceApp extends StatelessWidget {
  // App executed when Firebase connection succeeds
  final AppRouter router;
  final Repository repository = Repository();

  MarketplaceApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit(repository: repository),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(repository: repository),
        ),
        BlocProvider<CheckoutCubit>(
          create: (context) => CheckoutCubit(repository: repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marketplace App',
        theme: ThemeData(
          primarySwatch: primaryColor,
        ),
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
