import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gastro_office/api/http_client.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/impl/organization_entity.dart';

part 'select_organization_event.dart';

part 'select_organization_state.dart';

class SelectOrganizationBloc
    extends Bloc<SelectOrganizationEvent, SelectOrganizationState> {
  SelectOrganizationBloc() : super(SelectOrganizationInitial()) {
    on<SelectOrganizationInitEvent>((event, emit) async {
      final client = HttpClient(OAuthClient());
      final response = await client.get("/organizations/get/all");
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;

      emit(
        SelectOrganisationInitState(
            organizations: decodedResponse
                .map((e) => OrganizationEntity.fromJson(e))
                .toList()),
      );
    });

    on<OnSelectOrganizationEvent>((event, emit) async {
      final root = await getTemporaryDirectory();
      final organizationFile = File("${root.path}/organization.json");
      await organizationFile.create();
      await organizationFile
          .writeAsString(jsonEncode(event.organization.toJson()));

      emit(SelectedOrganisationState());
    });
  }
}
