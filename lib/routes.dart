import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/bloc/personal_data/personal_data_bloc.dart';
import 'package:gastro_office/routes/cart_route.dart';
import 'package:gastro_office/routes/main_route.dart';
import 'package:gastro_office/routes/news_list_route.dart';
import 'package:gastro_office/routes/news_route.dart';
import 'package:gastro_office/routes/offer_list_route.dart';
import 'package:gastro_office/routes/offer_route.dart';
import 'package:gastro_office/routes/personal_data_route.dart';
import 'package:gastro_office/routes/product_route.dart';
import 'package:gastro_office/routes/select_organisation_route.dart';

import 'bloc/cart/cart_bloc.dart';
import 'bloc/main/main_bloc.dart';
import 'bloc/news_list/news_list_bloc.dart';
import 'bloc/offer_list/offer_list_bloc.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/select_organisation/select_organization_bloc.dart';

final kRoutes = {
  "/offer": (context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return OfferRoute(
      offer: arguments["offer"],
      index: arguments["index"],
    );
  },
  "/newsList": (context) => BlocProvider(
        create: (context) => NewsListBloc()..add(NewsListInitEvent()),
        child: const NewsListRoute(),
      ),
  "/offerList": (context) => BlocProvider(
        create: (context) => OfferListBloc()..add(OfferListInitEvent()),
        child: const OfferListRoute(),
      ),
  "/selectOrganization": (context) => BlocProvider(
        create: (context) =>
            SelectOrganizationBloc()..add(SelectOrganizationInitEvent()),
        child: const SelectOrganizationRoute(),
      ),
  "/personalData": (context) => BlocProvider(
        create: (context) =>
            PersonalDataBloc()..add(PersonalDataInitEvent()),
        child: const PersonalDataRoute(),
      ),
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
  "/news": (context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return NewsRoute(news: arguments["news"]);
  },
};
