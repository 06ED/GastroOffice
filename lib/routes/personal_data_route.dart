import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/api/http_client.dart';
import 'package:gastro_office/bloc/personal_data/personal_data_bloc.dart';
import 'package:gastro_office/entities/impl/user_entity.dart';
import 'package:gastro_office/utils/loading.dart';

class PersonalDataRoute extends StatefulWidget {
  const PersonalDataRoute({super.key});

  @override
  State<PersonalDataRoute> createState() => _PersonalDataRouteState();
}

class _PersonalDataRouteState extends State<PersonalDataRoute> {
  final _boolSelect = [true, false];
  final _listSelect = ["Личные данные", "Доставка"];
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
        builder: (context, state) {
      if (state is PersonalDataInitState) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/main");
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: const Text("Личный кабинет"),
          ),
          body: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 20,
              children: [
                Center(
                  child: Text(
                    state.user.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 211, 138, 27),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ToggleButtons(
                    selectedBorderColor: Colors.grey,
                    borderColor: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    isSelected: _boolSelect,
                    children: _listSelect
                        .map((e) => Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.white,
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: _listSelect.indexOf(e) ==
                                          _boolSelect.indexOf(true)
                                      ? const Color.fromARGB(255, 211, 138, 27)
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ))
                        .toList(),
                    onPressed: (index) => setState(() {
                      for (int i = 0; i < _boolSelect.length; i++) {
                        _boolSelect[i] = i == index;
                      }
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Wrap(
                    children: _boolSelect[0]
                        ? [
                            _buildRow("Имя: ${state.user.name}", () {
                              _displayTextInputDialog(
                                  context, state.user, _NeedToChange.name);
                            }),
                          ]
                        : [
                            _buildRow("Этаж: ${state.user.floor}", () {
                              _displayTextInputDialog(
                                  context, state.user, _NeedToChange.floor);
                            }),
                            _buildRow("Номер места: ${state.user.workstation}",
                                () {
                              _displayTextInputDialog(context, state.user,
                                  _NeedToChange.workstation);
                            }),
                          ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return const Loading();
    });
  }

  Widget _buildRow(String text, VoidCallback onPressed) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(onPressed: onPressed, icon: const Icon(Icons.edit))
        ],
      );

  Future<void> _displayTextInputDialog(
      BuildContext context, UserEntity user, _NeedToChange need) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Изменение данных'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(
              hintText: "Введите",
            ),
            keyboardType:
                _boolSelect[1] ? TextInputType.number : TextInputType.name,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 211, 138, 27),
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                "Отмена",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                _changeData(user).then((value) {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 211, 138, 27),
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                "Изменить",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                UserEntity newUser;
                switch (need) {
                  case _NeedToChange.name:
                    newUser = UserEntity(
                      id: "",
                      name: _textFieldController.text,
                      floor: user.floor,
                      workstation: user.workstation,
                    );
                    break;
                  case _NeedToChange.floor:
                    newUser = UserEntity(
                      id: "",
                      name: user.name,
                      floor: int.parse(_textFieldController.text),
                      workstation: user.workstation,
                    );
                    break;
                  case _NeedToChange.workstation:
                    newUser = UserEntity(
                      id: "",
                      name: user.name,
                      floor: user.floor,
                      workstation: int.parse(_textFieldController.text),
                    );
                    break;
                }
                _changeData(newUser).then((value) {
                  Navigator.pushReplacementNamed(context, "/personalData");
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeData(UserEntity user) async {
    final client = HttpClient(OAuthClient());

    client.patch(
      "/user/update",
      headers: {"content-type": "application/json"},
      body: jsonEncode({
        "name": user.name,
        "floor": user.floor,
        "workstation": user.workstation,
      }),
    );
  }
}

enum _NeedToChange { name, floor, workstation }
