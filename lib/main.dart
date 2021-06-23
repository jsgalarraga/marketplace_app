import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/ui/router.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
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
