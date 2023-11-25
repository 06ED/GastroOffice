import 'package:gastro_office/entities/entity.dart';

class UserEntity extends Entity {
  final int floor;
  final int workstation;

  final String name;

  UserEntity({
    required super.id,
    required this.name,
    required this.floor,
    required this.workstation,
  });
}
