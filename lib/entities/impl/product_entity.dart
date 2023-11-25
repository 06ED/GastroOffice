import 'package:flutter/cupertino.dart';
import 'package:gastro_office/entities/entity.dart';
import 'package:gastro_office/settings.dart';

class ProductEntity extends Entity {
  final String title;
  final double cost;
  final String photoId;

  final double calories;
  final double proteins;
  final double fats;
  final double carbohydrates;

  Image get image => Image.network(
        "$kServerUrl/photos/download?id=$photoId",
        fit: BoxFit.fitWidth,
        width: double.infinity,
      );

  ProductEntity({
    required super.id,
    required this.title,
    required this.cost,
    required this.calories,
    required this.proteins,
    required this.carbohydrates,
    required this.fats,
    required this.photoId,
  });

  static ProductEntity fromJson(Map jsonEntity) {
    return ProductEntity(
      id: jsonEntity["id"],
      title: jsonEntity["title"],
      cost: jsonEntity["price"],
      calories: jsonEntity["calories"],
      proteins: jsonEntity["proteins"],
      carbohydrates: jsonEntity["carbohydrates"],
      fats: jsonEntity["fats"],
      photoId: jsonEntity["photo_id"],
    );
  }

  Map toJson() {
    return {
      "id": id,
      "title": title,
      "price": cost,
      "calories": calories,
      "proteins": proteins,
      "carbohydrates": carbohydrates,
      "fats": fats,
      "photo_id": photoId,
    };
  }
}
