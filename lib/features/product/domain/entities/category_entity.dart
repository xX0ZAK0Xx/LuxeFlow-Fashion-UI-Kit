import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final IconData? icon;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.icon,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, icon];
}
