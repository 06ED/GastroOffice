import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/bloc/select_provider/select_provider_bloc.dart';
import 'package:gastro_office/entities/impl/provider_entity.dart';

import '../utils/loading.dart';
import '../utils/nav_bar.dart';

class SelectProviderRoute extends StatefulWidget {
  const SelectProviderRoute({super.key});

  @override
  State<SelectProviderRoute> createState() => _SelectProviderRouteState();
}

class _SelectProviderRouteState extends State<SelectProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectProviderBloc, SelectProviderState>(
        builder: (context, state) {
      if (state is SelectProviderInitState) {
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
            title: const Text("Выберите провайдера"),
          ),
          body: ListView.builder(
            itemCount: state.providers.length,
            itemBuilder: (context, index) =>
                _buildItem(state.providers[index], () {
                  Navigator.pushReplacementNamed(context, "/main");
                }),
          ),
        );
      }
      return const Scaffold(
        body: Loading(),
        bottomNavigationBar: NavBar(id: 2),
      );
    });
  }

  Widget _buildItem(ProviderEntity provider, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 211, 138, 27),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          provider.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
