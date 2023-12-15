import 'package:flutter/material.dart';
import 'package:gastro_office/routes.dart';
import 'package:gastro_office/settings.dart';

void main() {
  runApp(const GastroOfficeApp());
}

class GastroOfficeApp extends StatelessWidget {
  const GastroOfficeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gastro Office',
      debugShowCheckedModeBanner: kDebug,
      debugShowMaterialGrid: kDebug,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 211, 138, 27),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            fontFamily: "KyivType",
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll<TextStyle>(
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        fontFamily: "KyivType",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: "/news",
      routes: kRoutes,
    );
  }
}
