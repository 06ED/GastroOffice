import 'package:gastro_office/entities/entity.dart';

class CategoryEntity extends Entity {
  final String title;
  final String description;

  CategoryEntity({
    required super.id,
    required this.title,
    required this.description,
  });

  static CategoryEntity fromJson(Map mapEntity) {
    return CategoryEntity(
      id: mapEntity["id"],
      title: mapEntity["title"],
      description: mapEntity["description"],
    );
  }
}
