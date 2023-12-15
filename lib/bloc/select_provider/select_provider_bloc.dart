import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gastro_office/api/http_client.dart';
import 'package:meta/meta.dart';

import '../../entities/impl/provider_entity.dart';

part 'select_provider_event.dart';
part 'select_provider_state.dart';

class SelectProviderBloc extends Bloc<SelectProviderEvent, SelectProviderState> {
  SelectProviderBloc() : super(SelectProviderInitial()) {
    on<SelectProviderInitEvent>((event, emit) async {
      final providers = <ProviderEntity>[];
      final client = HttpClient(OAuthClient());

      final response = await client.get("", );
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      providers.addAll(decodedResponse.map((e) => ProviderEntity.fromJson(e)));

      emit(SelectProviderInitState(providers: providers));
    });
  }
}
