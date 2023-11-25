import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gastro_office/api/http_client.dart';
import 'package:gastro_office/entities/impl/user_entity.dart';
import 'package:meta/meta.dart';

part 'personal_data_event.dart';
part 'personal_data_state.dart';

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc() : super(PersonalDataInitial()) {
    on<PersonalDataInitEvent>((event, emit) async {
      final client = HttpClient(OAuthClient());

      final response = await client.get("/user/info");
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

      emit(PersonalDataInitState(user: UserEntity(
        id: "",
        name: decodedResponse["name"],
        floor: decodedResponse["floor"],
        workstation: decodedResponse["workstation"]
      )));
    });
  }
}
