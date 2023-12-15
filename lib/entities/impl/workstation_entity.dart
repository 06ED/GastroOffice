import 'package:gastro_office/entities/entity.dart';

class WorkstationEntity extends Entity {
  final int placeNumber;
  final String userId;

  WorkstationEntity({
    required super.id,
    required this.placeNumber,
    required this.userId,
  });
}
