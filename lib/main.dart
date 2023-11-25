import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/bloc/cart/cart_bloc.dart';
import 'package:gastro_office/bloc/offer_list/offer_list_bloc.dart';
import 'package:gastro_office/bloc/product/product_bloc.dart';
import 'package:gastro_office/bloc/select_organisation/select_organization_bloc.dart';
import 'package:gastro_office/routes/cart_route.dart';
import 'package:gastro_office/routes/main_route.dart';
import 'package:gastro_office/routes/offer_list_route.dart';
import 'package:gastro_office/routes/offer_route.dart';
import 'package:gastro_office/routes/personal_data_route.dart';
import 'package:gastro_office/routes/product_route.dart';
import 'package:gastro_office/routes/select_organisation_route.dart';
import 'package:gastro_office/settings.dart';

import 'bloc/main/main_bloc.dart';

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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 211, 138, 27)),
        useMaterial3: true,
      ),
      initialRoute: "/main",
      routes: {
        "/offer": (context) {
          final arguments = (ModalRoute.of(context)?.settings.arguments ??
              <String, dynamic>{}) as Map;
          return OfferRoute(
            offer: arguments["offer"],
            index: arguments["index"],
          );
        },
        "/offerList": (context) => BlocProvider(
              create: (context) => OfferListBloc()..add(OfferListInitEvent()),
              child: const OfferListRoute(),
            ),
        "/selectOrganization": (context) => BlocProvider(
              create: (context) =>
                  SelectOrganizationBloc()..add(SelectOrganizationInitEvent()),
              child: const SelectOrganizationRoute(),
            ),
        "/personalData": (context) => const PersonalDataRoute(),
        "/main": (context) => BlocProvider(
              create: (context) => MainBloc()..add(MainInitEvent()),
              child: const MainRoute(),
            ),
        "/cart": (context) => BlocProvider(
              create: (context) => CartBloc()..add(CartInitEvent()),
              child: const CartRoute(),
            ),
        "/product": (context) {
          final arguments = (ModalRoute.of(context)?.settings.arguments ??
              <String, dynamic>{}) as Map;
          return BlocProvider(
            create: (context) => ProductBloc(),
            child: ProductsRoute(
              product: arguments["product"],
            ),
          );
        },
      },
    );
  }
}
