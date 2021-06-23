import 'package:flutter/material.dart';
import 'package:marketplace_app/ui/router.dart';

void main() {
  runApp(MarketplaceApp(
    router: AppRouter(),
  ));
}

class MarketplaceApp extends StatelessWidget {
  final AppRouter router;

  const MarketplaceApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketplace App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generateRoute,
    );
  }
}
