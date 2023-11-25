import 'package:flutter/material.dart';
import 'package:gastro_office/entities/entity.dart';

import '../../settings.dart';

class NewsEntity extends Entity {
  final String title;
  final String description;
  final String photoId;

  Image get image => Image.network(
        photoId,
        fit: BoxFit.cover,
        width: double.infinity,
      );

  NewsEntity({
    required super.id,
    required this.title,
    required this.description,
    required this.photoId,
  });
}
