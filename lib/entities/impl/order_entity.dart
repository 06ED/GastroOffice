import 'package:gastro_office/entities/entity.dart';
import 'package:gastro_office/entities/impl/product_entity.dart';

class OrderEntity extends Entity {
  final bool delivery, isCompleted;
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
      delivery: jsonEntity["delivery"],
      products: (jsonEntity["dishes"] as List)
          .map((e) => ProductEntity.fromJson(e))
          .toList(),
    );
  }
}
