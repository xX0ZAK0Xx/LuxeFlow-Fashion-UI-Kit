import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;

  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool isSale;
  final List<String> sizes;
  // final List<Color> colors; // Keeping it simple for now, using strings or hex in model if needed, or just skipping color logic complexity for pure UI demo unless requested. 
  // User requested "colors" field - let's add it as List<String> hex codes or names for simplicity in Entity
  final List<String> colors; 

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isNew = false,
    this.isSale = false,
    this.sizes = const [],
    this.colors = const [],
  });

  @override
  List<Object?> get props => [
        id, 
        name, 
        description, 
        price, 
        imageUrl, 
        categoryId,
        rating,
        reviewCount,
        isNew,
        isSale,
        sizes,
        colors,
      ];
}
