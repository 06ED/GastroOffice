import 'package:gastro_office/entities/entity.dart';

class LockerEntity extends Entity {
  final bool isLocked;
  final String lockerNumber;

  LockerEntity({
    required super.id,
    required this.isLocked,
    required this.lockerNumber,
  });
}
