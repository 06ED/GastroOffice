import 'package:flutter/material.dart';
import 'package:gastro_office/entities/impl/order_entity.dart';
import 'package:loading_animations/loading_animations.dart';

import '../entities/impl/product_entity.dart';
import '../utils/nav_bar.dart';

class OrderRoute extends StatefulWidget {
  final OrderEntity order;
  final int index;

  const OrderRoute({
    super.key,
    required this.order,
    required this.index,
  });

  @override
  State<OrderRoute> createState() => _OrderRouteState();
}

class _OrderRouteState extends State<OrderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Заказ №${widget.index + 1}"),
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
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) => _buildItem(
                  widget.order.products[index],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(30),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !widget.order.isCompleted
                          ? LoadingBouncingGrid.circle(
                              size: 30,
                              borderColor: Colors.black,
                              backgroundColor: Colors.black,
                            )
                          : const Icon(
                              Icons.check,
                              color: Colors.black,
                            ),
                      Text(
                        !widget.order.isCompleted
                            ? "  Готовим..."
                            : "  Заказ готов",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            widget.order.lockerNumber != null
                ? _getRow("Локер №", widget.order.lockerNumber.toString())
                : const Column(),
            _getRow(
                "Итог",
                widget.order.products
                    .fold(0.0, (p, c) => p + c.cost)
                    .toString()),
            _getRow(
                "Калории",
                widget.order.products
                    .fold(0.0, (p, c) => p + c.calories)
                    .toString()),
            _getRow(
                "Белки",
                widget.order.products
                    .fold(0.0, (p, c) => p + c.proteins)
                    .toString()),
            _getRow(
                "Жиры",
                widget.order.products
                    .fold(0.0, (p, c) => p + c.fats)
                    .toString()),
            _getRow(
                "Углеводы",
                widget.order.products
                    .fold(0.0, (p, c) => p + c.carbohydrates)
                    .toString()),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(id: 1),
    );
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
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Text(
          "${product.title.characters.take(30)}${product.title.length > 30 ? '...' : ''}\n"
          "${product.cost}Р\n"
          "КБЖУ: ${product.calories} "
          "${product.proteins} ${product.fats} ${product.carbohydrates}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
