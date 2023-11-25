import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/bloc/select_organisation/select_organization_bloc.dart';
import 'package:gastro_office/utils/loading.dart';

class SelectOrganizationRoute extends StatefulWidget {
  const SelectOrganizationRoute({super.key});

  @override
  State<SelectOrganizationRoute> createState() =>
      _SelectOrganizationRouteState();
}

class _SelectOrganizationRouteState extends State<SelectOrganizationRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectOrganizationBloc, SelectOrganizationState>(
      builder: (context, state) {
        if (state is SelectOrganisationInitState) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/personalData"),
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
              ],
              title: const Text(
                "Выберите организацию",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: state.organizations.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    context.read<SelectOrganizationBloc>().add(
                          OnSelectOrganizationEvent(
                            organization: state.organizations[index],
                          ),
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${state.organizations[index].title} - ${state.organizations[index].address}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          state.organizations[index].description,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const Loading();
      },
      listener: (context, state) {
        if (state is SelectedOrganisationState) {
          Navigator.popAndPushNamed(context, "/main");
        }
      },
    );
  }
}
