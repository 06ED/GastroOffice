import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gastro_office/api/http_client.dart';
import 'package:meta/meta.dart';

import '../../entities/impl/order_entity.dart';

part 'offer_list_event.dart';

part 'offer_list_state.dart';

class OfferListBloc extends Bloc<OfferListEvent, OfferListState> {
  OfferListBloc() : super(OfferListInitial()) {
    on<OfferListInitEvent>((event, emit) async {
      final client = HttpClient(OAuthClient());
      final response = await client.get("/order/get/all");
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;

      emit(OfferListInitState(
        offers: decodedResponse.map((e) => OrderEntity.fromJson(e)).toList(),
      ));
    });
  }
}
