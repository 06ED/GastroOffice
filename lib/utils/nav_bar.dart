import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final int id;

  const NavBar({super.key, required this.id});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  static const kRouteToId = {
    0: "/newsList",
    1: "/offerList",
    2: "/main",
    3: "/cart",
  };

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      indicatorColor: const Color.fromARGB(255, 211, 138, 27),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: widget.id,
      onDestinationSelected: (int index) =>
          Navigator.pushNamed(context, kRouteToId[index]!),
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.notification_important),
          selectedIcon: Icon(
            Icons.notification_important,
            color: Colors.white,
          ),
          label: "Новости",
        ),
        NavigationDestination(
          icon: Icon(Icons.local_offer),
          selectedIcon: Icon(
            Icons.local_offer,
            color: Colors.white,
          ),
          label: "Заказы",
        ),
        NavigationDestination(
          icon: Icon(Icons.home),
          selectedIcon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: "Меню",
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_cart),
          selectedIcon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          label: "Корзина",
        ),
      ],
    );
  }
}
