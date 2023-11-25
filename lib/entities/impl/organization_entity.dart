import 'package:gastro_office/entities/entity.dart';

class OrganizationEntity extends Entity {
  final String title;
  final String description;
  final String address;

  OrganizationEntity({
    required super.id,
    required this.title,
    required this.description,
    required this.address,
  });

  static OrganizationEntity fromJson(Map mapEntity) {
    return OrganizationEntity(
      id: mapEntity["id"],
      title: mapEntity["title"],
      description: mapEntity["description"],
      address: mapEntity["address"],
    );
  }

  Map toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "address": address,
    };
  }
}
