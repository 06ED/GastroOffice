import 'package:gastro_office/entities/entity.dart';

class UserEntity extends Entity {
  final int floor;
  final int workstation;

  final String name;
  final String surname;

  UserEntity({
    required super.id,
    required this.name,
    required this.surname,
    required this.floor,
    required this.workstation,
  });
}
