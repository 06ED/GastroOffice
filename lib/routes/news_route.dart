import 'package:flutter/material.dart';
import 'package:gastro_office/entities/impl/news_entity.dart';

import '../utils/nav_bar.dart';

class NewsRoute extends StatefulWidget {
  final NewsEntity news;

  const NewsRoute({super.key, required this.news});

  @override
  State<NewsRoute> createState() => _NewsRouteState();
}

class _NewsRouteState extends State<NewsRoute> {
  @override
  Widget build(BuildContext context) {
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
          widget.news.title,
          style: const TextStyle(
            fontFamily: "KyivType",
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: widget.news.image,
              ),
              const Padding(padding: EdgeInsets.all(20)),
              Text(
                widget.news.description,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(id: 0),
    );
  }
}
