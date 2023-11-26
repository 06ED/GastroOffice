import 'package:flutter/material.dart';
import 'package:gastro_office/entities/entity.dart';

import '../../settings.dart';

class NewsEntity extends Entity {
  final String title;
  final String description;
  final String photoId;

  Image get image => Image.network(
        "$kServerUrl/photos/download?id=$photoId",
        fit: BoxFit.cover,
        width: double.infinity,
      );

  NewsEntity({
    required super.id,
    required this.title,
    required this.description,
    required this.photoId,
  });

  static NewsEntity fromJson(Map mapEntity) {
    return NewsEntity(
      id: mapEntity["id"],
      title: mapEntity["title"],
      description: mapEntity["body"],
      photoId: mapEntity["photo_id"],
    );
  }
}
