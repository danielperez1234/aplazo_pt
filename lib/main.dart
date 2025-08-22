import 'package:aplazo_pt/core/injection/injection_container.dart';
import 'package:aplazo_pt/features/details/presentation/pages/details_page.dart';
import 'package:aplazo_pt/features/home/presentation/pages/home_page.dart';
import 'package:aplazo_pt/features/serch_by_name/presentation/pages/search_by_name_page.dart';
import 'package:flutter/material.dart';

void main() {
  initInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        HomePage.routeName: (context) => const HomePage(),
        SearchByNamePage.routeName: (context) => const SearchByNamePage(),
        DetailsPage.routeName: (context) => const DetailsPage(),
      },
    );
  }
}
