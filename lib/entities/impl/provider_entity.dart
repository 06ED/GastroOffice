import 'package:gastro_office/entities/entity.dart';

class ProviderEntity extends Entity {
  final String description;
  final String title;
  final String organizationId;

  ProviderEntity({
    required super.id,
    required this.description,
    required this.title,
    required this.organizationId,
  });

  static fromJson(Map mapEntity) {
    return ProviderEntity(
      id: mapEntity["id"],
      description: mapEntity["description"],
      title: mapEntity["title"],
      organizationId: mapEntity["organisation_id"],
    );
  }
}
