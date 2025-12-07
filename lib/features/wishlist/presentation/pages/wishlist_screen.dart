import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/product_card.dart';
import '../blocs/wishlist_bloc.dart';
import '../../../product/presentation/pages/product_details_screen.dart';
import '../../../cart/presentation/blocs/cart_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        centerTitle: true,
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            if (state.wishlist.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Your wishlist is empty',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.wishlist.length,
              itemBuilder: (context, index) {
                final product = state.wishlist[index];
                final heroTag = 'wishlist_product_${product.id}';
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
                     context.read<CartBloc>().add(AddProductToCart(product));
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('${product.name} added to cart')),
                     );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
