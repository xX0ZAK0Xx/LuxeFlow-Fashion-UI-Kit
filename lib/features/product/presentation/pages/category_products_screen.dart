import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/product_card.dart';
import '../../domain/entities/category_entity.dart';
import '../blocs/product_bloc.dart';
import '../pages/product_details_screen.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_icons.dart';

class CategoryProductsScreen extends StatelessWidget {
  final CategoryEntity category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.filter),
            onPressed: () {
              // Show filter modal
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            final categoryProducts = state.featuredProducts.where((p) => p.categoryId == category.id).toList();
            
            // If no actual match in mock data (since mock data IDs might not align perfectly 1-to-1 with random categories in this demo setup unless rigorously aligned), show all or empty.
            // But I updated mock data to have categoryIds '1' to '12'. 
            // Let's assume alignment is correct.
            
            if (categoryProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(AppIcons.cart, size: 64, color: Colors.grey),
                    const SizedBox(height: AppDimens.paddingMedium),
                    Text('No products found in ${category.name}', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(AppDimens.paddingMedium),
              itemCount: categoryProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 0.58,
                 crossAxisSpacing: AppDimens.paddingMedium,
                 mainAxisSpacing: AppDimens.paddingMedium,
              ),
              itemBuilder: (context, index) {
                final product = categoryProducts[index];
                final heroTag = 'category_product_${product.id}';
                return ProductCard(
                  product: product,
                  heroTag: heroTag,
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(product: product, heroTag: heroTag),
                      ),
                    );
                  },
                  onAddToCart: () {
                     // Add to cart logic (copy from home or use helper)
                  },
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
}
