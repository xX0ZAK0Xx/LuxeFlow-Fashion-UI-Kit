import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luxeflow_fashion_ui_kit/core/constants/app_dimens.dart';
import '../../../../core/widgets/custom_filter_chip.dart';
import '../../../../core/widgets/image_carousel.dart';
import '../../../../core/widgets/size_guide_modal.dart';
import '../../domain/entities/product_entity.dart';
import '../../../../features/cart/presentation/blocs/cart_bloc.dart';
import '../../../wishlist/presentation/blocs/wishlist_bloc.dart';


class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  final String? heroTag;

  const ProductDetailsScreen({
    super.key, 
    required this.product,
    this.heroTag,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ValueNotifier<String> _selectedSizeNotifier = ValueNotifier('M');
  final ValueNotifier<String> _selectedColorNotifier = ValueNotifier('Black');

  @override
  void dispose() {
    _selectedSizeNotifier.dispose();
    _selectedColorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock multiple images for the carousel
    final List<String> images = [
      widget.product.imageUrl,
      widget.product.imageUrl, // Duplicate for demo
      widget.product.imageUrl, // Duplicate for demo
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''), // Transparent app bar
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
             icon: BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                   bool isLiked = false;
                   if (state is WishlistLoaded) {
                     isLiked = state.wishlist.any((p) => p.id == widget.product.id);
                   }
                   return Icon(
                     isLiked ? Icons.favorite : Icons.favorite_border,
                     color: isLiked ? Colors.red : Colors.black,
                   );
                },
             ),
             onPressed: () {
               context.read<WishlistBloc>().add(ToggleWishlistItem(widget.product));
             },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Carousel
                  Stack(
                    children: [
                      Hero(
                        tag: widget.heroTag ?? 'product_image_${widget.product.id}',
                        child: ImageCarousel(imageUrls: images, height: 450),
                      ),
                    ],
                  ),
                  
                  Container(
                    transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.name,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Text(
                              '\$${widget.product.price}',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Text(' 4.8 (120 reviews)', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Size Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Select Size', style: Theme.of(context).textTheme.titleMedium),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => const SizeGuideModal(),
                                );
                              },
                              child: const Text('Size Guide'),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ValueListenableBuilder<String>(
                            valueListenable: _selectedSizeNotifier,
                            builder: (context, selectedSize, _) {
                              return Row(
                                children: ['S', 'M', 'L', 'XL'].map((size) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CustomFilterChip(
                                      label: size,
                                      isSelected: selectedSize == size,
                                      onSelected: () {
                                        _selectedSizeNotifier.value = size;
                                      },
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Color Selector
                        Text('Select Color', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        ValueListenableBuilder<String>(
                          valueListenable: _selectedColorNotifier,
                          builder: (context, selectedColor, _) {
                            return Row(
                              children: ['Black', 'Blue', 'Beige'].map((color) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _selectedColorNotifier.value = color;
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: _getColor(color),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: selectedColor == color ? Theme.of(context).primaryColor : Colors.grey[300]!,
                                          width: 2,
                                        ),
                                        boxShadow: selectedColor == color
                                            ? [BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 2)]
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        Text('Description', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Html(
                          data: widget.product.description,
                          style: {
                            "body": Style(
                              fontSize: FontSize(16.0),
                              color: Colors.grey[700],
                              lineHeight: LineHeight(1.5),
                              fontFamily: 'Roboto', // Or your app's font
                            ),
                            "strong": Style(fontWeight: FontWeight.bold, color: Colors.black),
                            "li": Style(
                               margin: Margins.only(bottom: 4), // Properly spaced list items
                            ),
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        Text('Reviews', style: Theme.of(context).textTheme.titleMedium),
                        // Mock Review Item
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const CircleAvatar(child: Text('JD')),
                          title: const Text('John Doe'),
                          subtitle: const Text('Great quality and fits perfectly!'),
                          trailing: const Icon(Icons.star, color: Colors.amber, size: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.p16),
          child: ElevatedButton(
            onPressed: () {
              context.read<CartBloc>().add(AddProductToCart(
                widget.product,
                color: _selectedColorNotifier.value,
                size: _selectedSizeNotifier.value,
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.product.name} added to cart')),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Add to Cart'),
          ),
        ),
      ),
    );
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'Black': return Colors.black;
      case 'Blue': return Colors.blue[900]!;
      case 'Beige': return const Color(0xFFF5F5DC);
      default: return Colors.black;
    }
  }
}
