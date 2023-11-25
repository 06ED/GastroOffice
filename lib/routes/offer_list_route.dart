import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/bloc/offer_list/offer_list_bloc.dart';
import 'package:gastro_office/utils/loading.dart';
import 'package:gastro_office/utils/nav_bar.dart';

class OfferListRoute extends StatefulWidget {
  const OfferListRoute({super.key});

  @override
  State<OfferListRoute> createState() => _OfferListRouteState();
}

class _OfferListRouteState extends State<OfferListRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferListBloc, OfferListState>(
        builder: (context, state) {
      if (state is OfferListInitState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Заказы"),
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, "/personalData"),
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: state.offers.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/offer", arguments: {
                    "index": index,
                    "offer": state.offers[index],
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Заказ №${index + 1}",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: const NavBar(id: 1),
        );
      }
      return const Scaffold(
        body: Loading(),
        bottomNavigationBar: NavBar(id: 1),
      );
    });
  }
}
