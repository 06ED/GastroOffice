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
                onPressed: () => Navigator.pushReplacementNamed(context, "/personalData"),
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: state.offers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Пока заказов нет",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/cart");
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 211, 138, 27),
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text(
                            "Корзина",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
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
