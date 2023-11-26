import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/bloc/product/product_bloc.dart';
import 'package:gastro_office/entities/impl/product_entity.dart';

class ProductsRoute extends StatefulWidget {
  final ProductEntity product;

  const ProductsRoute({
    super.key,
    required this.product,
  });

  @override
  State<ProductsRoute> createState() => _ProductsRouteState();
}

class _ProductsRouteState extends State<ProductsRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => Navigator.pushReplacementNamed(context, "/personalData"),
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
            ],
            title: Text(
              widget.product.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 50,
                children: [
                  widget.product.image,
                  Text(
                    "${widget.product.cost}Р",
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Column(
                    children: [
                      _getRow("Калории", widget.product.calories.toString()),
                      _getRow("Белки", widget.product.proteins.toString()),
                      _getRow("Жиры", widget.product.fats.toString()),
                      _getRow(
                          "Углеводы", widget.product.carbohydrates.toString()),
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 211, 138, 27),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(AddToCartProductEvent(products: [widget.product]));
                      Navigator.popAndPushNamed(context, "/main");
                    },
                    child: const Text(
                      "В корзину",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getRow(String key, String value) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20),
          )
        ],
      );
}
