import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gastro_office/api/http_client.dart';
import 'package:gastro_office/entities/impl/organization_entity.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/impl/category_entity.dart';
import '../../entities/impl/product_entity.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<UpdateCategoryEvent>((event, emit) async {
      final list = <ProductEntity>[];
      final client = HttpClient(OAuthClient());
      await client.getToken();

      final root = await getTemporaryDirectory();
      final organizationFile = File("${root.path}/organization.json");
      if (!await organizationFile.exists()) {
        return emit(MainInitState(
          products: const [],
          categories: const [],
          needToSelectOrganization: true,
        ));
      }
      final organizationId = jsonDecode(await organizationFile.readAsString());
      final catResponse = await client.post(
        "/categories/get/by/organization",
        headers: {"content-type": "application/json"},
        body: jsonEncode({"organization_id": organizationId["id"]}),
      );
      final decodedCatResponse =
          jsonDecode(utf8.decode(catResponse.bodyBytes)) as List;

      if (decodedCatResponse.isEmpty) {
        return emit(MainInitState(
            products: const [],
            categories: const [],
            needToSelectOrganization: false));
      }

      final response = await client.post("/dishes/get/by/category",
          headers: {"content-type": "application/json"},
          body: jsonEncode({
            "category_id": decodedCatResponse
                .where((element) => element["id"] == event.category.id)
                .first["id"],
          }));
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;
      list.addAll(decodedResponse.map((e) => ProductEntity.fromJson(e)));

      emit(MainInitState(
        products: list,
        categories:
            decodedCatResponse.map((e) => CategoryEntity.fromJson(e)).toList(),
        needToSelectOrganization: false,
      ));
    });

    on<MainInitEvent>((event, emit) async {
      final list = <ProductEntity>[];
      final client = HttpClient(OAuthClient());
      await client.getToken();

      final root = await getTemporaryDirectory();
      final organizationFile = File("${root.path}/organization.json");
      if (!await organizationFile.exists()) {
        return emit(MainInitState(
          products: const [],
          categories: const [],
          needToSelectOrganization: true,
        ));
      }
      final organizationId = jsonDecode(await organizationFile.readAsString());
      final catResponse = await client.post(
        "/categories/get/by/organization",
        headers: {"content-type": "application/json"},
        body: jsonEncode({"organization_id": organizationId["id"]}),
      );
      final decodedCatResponse =
          jsonDecode(utf8.decode(catResponse.bodyBytes)) as List;

      if (decodedCatResponse.isEmpty) {
        return emit(MainInitState(
            products: const [],
            categories: const [],
            needToSelectOrganization: false));
      }

      final response = await client.post("/dishes/get/by/category",
          headers: {"content-type": "application/json"},
          body: jsonEncode({
            "category_id": decodedCatResponse[0]["id"],
          }));
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;
      list.addAll(decodedResponse.map((e) => ProductEntity.fromJson(e)));

      emit(MainInitState(
        products: list,
        categories:
            decodedCatResponse.map((e) => CategoryEntity.fromJson(e)).toList(),
        needToSelectOrganization: false,
      ));
    });
  }
}
