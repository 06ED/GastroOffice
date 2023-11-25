import 'package:flutter/material.dart';
import 'package:gastro_office/entities/impl/user_entity.dart';

class PersonalDataRoute extends StatefulWidget {
  const PersonalDataRoute({super.key});

  @override
  State<PersonalDataRoute> createState() => _PersonalDataRouteState();
}

class _PersonalDataRouteState extends State<PersonalDataRoute> {
  final _boolSelect = [true, false];
  final _listSelect = ["Личные данные", "Доставка"];

  @override
  Widget build(BuildContext context) {
    final UserEntity user = UserEntity(
        id: "1", name: "name", surname: "surname", floor: 21, workstation: 123);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 138, 27),
        title: const Text(
          "Личный кабинет",
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: [
            Text(
              "${user.name} ${user.surname}",
              style: const TextStyle(
                color: Color.fromARGB(255, 211, 138, 27),
                fontSize: 30,
                fontWeight: FontWeight.bold,
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
                        _buildRow("Имя: ${user.name}", () {}),
                        _buildRow("Фамилия: ${user.surname}", () {}),
                      ]
                    : [
                        _buildRow("Этаж: ${user.floor}", () {}),
                        _buildRow("Номер места: ${user.workstation}", () {}),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
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
}
