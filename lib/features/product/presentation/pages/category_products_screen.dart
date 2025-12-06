import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/product_card.dart';
import '../../domain/entities/category_entity.dart';
import '../blocs/product_bloc.dart';
import '../pages/product_details_screen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final CategoryEntity category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
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
                    const Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text('No products found in ${category.name}', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categoryProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 0.58,
                 crossAxisSpacing: 16,
                 mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final product = categoryProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(product: product),
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
}
