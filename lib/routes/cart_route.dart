import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/bloc/cart/cart_bloc.dart';
import 'package:gastro_office/utils/loading.dart';
import 'package:gastro_office/utils/nav_bar.dart';
import 'package:path_provider/path_provider.dart';

import '../api/http_client.dart';
import '../entities/impl/product_entity.dart';
import '../utils/delivery_mode.dart';

class CartRoute extends StatefulWidget {
  const CartRoute({super.key});

  @override
  State<CartRoute> createState() => _CartRouteState();
}

class _CartRouteState extends State<CartRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartInitState) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, "/personalData"),
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
              ],
              backgroundColor: const Color.fromARGB(255, 211, 138, 27),
              title: const Text("Корзина"),
            ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) => _buildItem(
                        state.products[index],
                      ),
                    ),
                  ),
                  _getRow(
                      "Итог",
                      state.products
                          .fold(0.0, (p, c) => p + c.cost)
                          .toString()),
                  _getRow(
                      "Калории",
                      state.products
                          .fold(0.0, (p, c) => p + c.calories)
                          .toString()),
                  _getRow(
                      "Белки",
                      state.products
                          .fold(0.0, (p, c) => p + c.proteins)
                          .toString()),
                  _getRow(
                      "Жиры",
                      state.products
                          .fold(0.0, (p, c) => p + c.fats)
                          .toString()),
                  _getRow(
                      "Углеводы",
                      state.products
                          .fold(0.0, (p, c) => p + c.carbohydrates)
                          .toString()),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () => _getDialog(),
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 211, 138, 27),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text(
                          "Заказать",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const NavBar(id: 3),
          );
        }
        return const Scaffold(
          body: Loading(),
          bottomNavigationBar: NavBar(id: 3),
        );
      },
    );
  }

  ButtonStyle _getDialogButtonStyle() {
    return TextButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 211, 138, 27),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Future<void> _getDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Доставка"),
        content: const Text(
          'Выберите, где вы бы хотели получить ваш заказ',
        ),
        actions: [
          TextButton(
            style: _getDialogButtonStyle(),
            child: const Text(
              "Доставить",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              _addOrder(DeliveryMode.table)
                  .then((value) => Navigator.pushReplacementNamed(context, "/offerList"));
            },
          ),
          TextButton(
            style: _getDialogButtonStyle(),
            child: const Text(
              "Заберу сам",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _addOrder(DeliveryMode.disabled)
                  .then((value) => Navigator.pushReplacementNamed(context, "/offerList"));
            },
          ),
          TextButton(
            style: _getDialogButtonStyle(),
            child: const Text(
              "В контейнер",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _addOrder(DeliveryMode.container)
                  .then((value) => Navigator.pushReplacementNamed(context, "/offerList"));
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addOrder(DeliveryMode delivery) async {
    final root = await getTemporaryDirectory();
    final file = File("${root.path}/cart.json");
    final orgFile = File("${root.path}/organization.json");
    final client = HttpClient(OAuthClient());

    if (await file.exists()) {
      final jsonList =
          jsonDecode(utf8.decode(await file.readAsBytes())) as List;
      await client.put("/order/create",
          headers: {"content-type": "application/json"},
          body: jsonEncode({
            "dishes_id": jsonList.map((e) => e["id"]).toList(),
            "delivery": delivery.id,
            "organization_id": jsonDecode(await orgFile.readAsString())["id"],
          }));

      await file.delete();
    }
  }

  Widget _getRow(String key, String value) => Text(
        "$key: $value",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _buildItem(ProductEntity product) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 211, 138, 27),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Text(
              "${product.title.characters.take(30)}${product.title.length > 30 ? '...' : ''}\n"
              "${product.cost}Р\n"
              "КБЖУ: ${product.calories} "
              "${product.proteins} ${product.fats} ${product.carbohydrates}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(DeleteProductFromCartEvent(product: product));
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 211, 138, 27),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: const Text(
              "Удалить",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
