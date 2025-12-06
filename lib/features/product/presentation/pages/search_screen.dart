import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/filter_modal.dart';
import '../../../../core/widgets/product_card.dart';
import '../blocs/product_bloc.dart';
import 'product_details_screen.dart';
import '../../../../features/cart/presentation/blocs/cart_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const FilterModal(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products, brands...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<ProductBloc>().add(const SearchProducts(''));
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {}); // Updates suffix icon
                  // Debounce could be added here
                  context.read<ProductBloc>().add(SearchProducts(value));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductsLoaded) {
                    if (state.products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No results found',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
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
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
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
                             context.read<CartBloc>().add(AddProductToCart(product));
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('${product.name} added to cart')),
                             );
                          },
                        );
                      },
                    );
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  
                  // Default state (Suggestions)
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Searches',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: ['Winter Coat', 'Black Dress', 'Leather Boots', 'Scarf'].map((search) {
                              return ActionChip(
                                label: Text(search),
                                avatar: const Icon(Icons.history, size: 16, color: Colors.grey),
                                backgroundColor: Theme.of(context).cardColor,
                                side: BorderSide(color: Colors.grey.shade200),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  _searchController.text = search;
                                  context.read<ProductBloc>().add(SearchProducts(search));
                                  setState(() {});
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                          
                          Text(
                            'Popular Products',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          SizedBox( 
                             height: 320,
                             child: state is DashboardLoaded 
                             ? ListView.builder(
                               scrollDirection: Axis.horizontal,
                               itemCount: state.featuredProducts.length,
                               itemBuilder: (context, index) {
                                  final product = state.featuredProducts[index];
                                  return Container(
                                   width: 180,
                                   margin: const EdgeInsets.only(right: 12),
                                   child: ProductCard(
                                     product: product,
                                     onTap: () {
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
                                       );
                                     },
                                     onAddToCart: () {
                                       context.read<CartBloc>().add(AddProductToCart(product));
                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} added to cart')));
                                     },
                                   ),
                                 );
                               },
                             )
                             : const Center(child: CircularProgressIndicator()),
                          ),

                          const SizedBox(height: 24),
                          Text(
                            'Recommended for You',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          // List of text links or categories
                           Column(
                             children: ['New Arrivals in Shoes', 'Best Sellers in Accessories', 'Sale Items'].map((item) {
                               return ListTile(
                                 contentPadding: EdgeInsets.zero,
                                 leading: Container(
                                   padding: const EdgeInsets.all(8),
                                   decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
                                   child: const Icon(Icons.trending_up, size: 20, color: Colors.blue),
                                 ),
                                 title: Text(item, style: const TextStyle(fontWeight: FontWeight.w500)),
                                 trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                                 onTap: () {},
                               );
                             }).toList(),
                           ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
