import 'package:gastro_office/entities/entity.dart';
import 'package:gastro_office/entities/impl/product_entity.dart';

class OrderEntity extends Entity {
  final bool isCompleted;
  final int? lockerNumber;
  final int? workstationNumber;
  final List<ProductEntity> products;

  OrderEntity({
    required super.id,
    required this.isCompleted,
    required this.lockerNumber,
    required this.workstationNumber,
    required this.products,
  });

  static OrderEntity fromJson(Map jsonEntity) {
    return OrderEntity(
      id: jsonEntity["id"],
      isCompleted: jsonEntity["is_completed"],
      lockerNumber: jsonEntity["locker_number"],
      workstationNumber: jsonEntity["workstation_number"],
      products: (jsonEntity["dishes"] as List)
          .map((e) => ProductEntity.fromJson(e))
          .toList(),
    );
  }
}
