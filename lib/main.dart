import 'package:flutter/material.dart';
import 'package:flutter_assignment/provider/location_provider.dart';
import 'package:flutter_assignment/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'data/api/api_service.dart';
import 'data/repository/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            final ApiService apiService = ApiService();
            final Repository repository = Repository(apiService: apiService);
            return LocationProvider(repository: repository);
          })
        ],
        child: MaterialApp(
          title: 'TCS Locator',
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              color: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          ),
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(title: 'TCS Locator'),
        ));
  }
}
