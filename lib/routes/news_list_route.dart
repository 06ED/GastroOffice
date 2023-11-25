import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/utils/loading.dart';
import 'package:gastro_office/utils/nav_bar.dart';

import '../bloc/news_list/news_list_bloc.dart';

class NewsListRoute extends StatefulWidget {
  const NewsListRoute({super.key});

  @override
  State<NewsListRoute> createState() => _NewsListRouteState();
}

class _NewsListRouteState extends State<NewsListRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListBloc, NewsListState>(
      builder: (context, state) {
        if (state is NewsListInitState) {
          return Scaffold(
            appBar: AppBar(title: const Text("Новости"), actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, "/personalData"),
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
            ]),
            body: ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/news", arguments: {
                      "news": state.news[index],
                    });
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: state.news[index].image,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Wrap(
                          runSpacing: 20,
                          children: [
                            Text(
                              state.news[index].title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.news[index].description.length > 100
                                  ? "${state.news[index].description.characters.take(100).string}..."
                                  : state.news[index].description,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const NavBar(id: 0),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Новости"),
          ),
          body: const Loading(),
          bottomNavigationBar: const NavBar(id: 0),
        );
      },
    );
  }
}
