import 'package:gastro_office/entities/entity.dart';
import 'package:gastro_office/entities/impl/product_entity.dart';
import 'package:gastro_office/utils/delivery_mode.dart';

class OrderEntity extends Entity {
  final bool isCompleted;
  final DeliveryMode delivery;
  final List<ProductEntity> products;

  OrderEntity({
    required super.id,
    required this.isCompleted,
    required this.delivery,
    required this.products,
  });

  static OrderEntity fromJson(Map jsonEntity) {
    return OrderEntity(
      id: jsonEntity["id"],
      isCompleted: jsonEntity["is_completed"],
      delivery: DeliveryMode.values.singleWhere((element) =>  jsonEntity["delivery"] == element.id),
      products: (jsonEntity["dishes"] as List)
          .map((e) => ProductEntity.fromJson(e))
          .toList(),
    );
  }
}
