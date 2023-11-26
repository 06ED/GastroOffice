import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/bloc/main/main_bloc.dart';
import 'package:gastro_office/entities/impl/product_entity.dart';
import 'package:gastro_office/utils/loading.dart';
import 'package:gastro_office/utils/nav_bar.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({super.key});

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        if (state is MainInitState && state.needToSelectOrganization) {
          Navigator.popAndPushNamed(context, "/selectOrganization");
          return;
        }
      },
      builder: (BuildContext context, state) {
        if (state is MainInitState) {
          final List<ProductEntity> products = _filterProducts(state.products);

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
              backgroundColor: const Color.fromARGB(255, 211, 138, 27),
              title: const Text(
                "Меню",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: SearchBar(
                    hintText: "Поиск",
                    controller: _controller,
                    side: const MaterialStatePropertyAll<BorderSide>(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    surfaceTintColor:
                        const MaterialStatePropertyAll<Color>(Colors.white),
                    shape:
                        const MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    shadowColor: const MaterialStatePropertyAll<Color>(
                      Color.fromARGB(0, 0, 0, 0),
                    ),
                    trailing: const [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      )
                    ],
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: state.categories
                      .map(
                        (e) => _getVariant(
                          e.title,
                          () => context
                              .read<MainBloc>()
                              .add(UpdateCategoryEvent(category: e)),
                        ),
                      )
                      .toList(),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: (products.length % 2 == 0 ? 0 : 1) +
                          products.length ~/ 2,
                      itemBuilder: (context, index) {
                        if (index + 2 >= products.length) {
                          return Center(
                            child: _getItemCard(products[index]),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _getItemCard(products[index]),
                            _getItemCard(products[index + 2]),
                          ],
                        );
                      }),
                ),
              ],
            ),
            bottomNavigationBar: const NavBar(id: 2),
          );
        }
        return const Scaffold(
          body: Loading(),
          bottomNavigationBar: NavBar(id: 2),
        );
      },
    );
  }

  List<ProductEntity> _filterProducts(List<ProductEntity> productsToFilter) =>
      productsToFilter
          .where((element) => element.title
              .toLowerCase()
              .contains(_controller.text.toLowerCase()))
          .toList();

  Widget _getVariant(String text, VoidCallback onPress) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  Widget _getItemCard(ProductEntity product) {
    return Container(
      width: 170,
      height: 250,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/product", arguments: {
              "product": product,
            });
          },
          child: Wrap(
            children: [
              SizedBox(
                height: 120,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: product.image,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Цена: ${product.cost}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
