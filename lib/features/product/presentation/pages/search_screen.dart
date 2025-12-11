import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/filter_modal.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../blocs/product_bloc.dart';
import 'product_details_screen.dart';
import '../../../../features/cart/presentation/blocs/cart_bloc.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

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
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.adjustments),
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
              padding: const EdgeInsets.all(AppDimens.paddingMedium),
              child: CustomTextField(
                controller: _searchController,
                hintText: 'Search products, brands...',
                prefixIcon: AppIcons.search,
                suffix: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder: (context, value, child) => value.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(AppIcons.close, color: Theme.of(context).disabledColor),
                            onPressed: () {
                              _searchController.clear();
                              context.read<ProductBloc>().add(const SearchProducts(''));
                            },
                          )
                        : const SizedBox.shrink(),
                ),
                onChanged: (value) {
                  // Debounce could be added here
                  context.read<ProductBloc>().add(SearchProducts(value));
                }, label: 'Search',
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
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
                            Icon(AppIcons.searchOff, size: 64, color: Theme.of(context).disabledColor),
                            const SizedBox(height: AppDimens.paddingMedium),
                            Text(
                              'No results found',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(AppDimens.paddingMedium),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: AppDimens.paddingMedium,
                        mainAxisSpacing: AppDimens.paddingMedium,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        final heroTag = 'search_result_${product.id}';
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
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  
                  // Default state (Suggestions)
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.paddingMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Searches',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: AppDimens.paddingMedium),
                          Wrap(
                            spacing: 8,
                            runSpacing: AppDimens.paddingSmall,
                            children: ['Winter Coat', 'Black Dress', 'Leather Boots', 'Scarf'].map((search) => ActionChip(
                                label: Text(search),
                                avatar: const Icon(AppIcons.history, size: AppDimens.iconSmall, color: Colors.grey),
                                backgroundColor: Theme.of(context).cardColor,
                                side: BorderSide(color: Theme.of(context).dividerColor),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  _searchController.text = search;
                                  context.read<ProductBloc>().add(SearchProducts(search));
                                  setState(() {});
                                },
                              )).toList(),
                          ),
                          const SizedBox(height: AppDimens.paddingLarge),
                          
                          Text(
                            'Popular Products',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: AppDimens.paddingMedium),
                          SizedBox( 
                             height: 320,
                             child: state is DashboardLoaded 
                             ? ListView.builder(
                               scrollDirection: Axis.horizontal,
                               itemCount: state.featuredProducts.length,
                               itemBuilder: (context, index) {
                                  final product = state.featuredProducts[index];
                                  final heroTag = 'search_popular_${product.id}';
                                  return Container(
                                   width: 180,
                                   margin: const EdgeInsets.only(right: AppDimens.radiusMedium),
                                   child: ProductCard(
                                     product: product,
                                     heroTag: heroTag,
                                     onTap: () {
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product, heroTag: heroTag)),
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

                          const SizedBox(height: AppDimens.paddingLarge),
                          Text(
                            'Recommended for You',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: AppDimens.paddingMedium),
                          // List of text links or categories
                           Column(
                             children: ['New Arrivals in Shoes', 'Best Sellers in Accessories', 'Sale Items'].map((item) => ListTile(
                                 contentPadding: EdgeInsets.zero,
                                 leading: Container(
                                   padding: const EdgeInsets.all(AppDimens.paddingSmall),
                                   decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, shape: BoxShape.circle),
                                   child: const Icon(AppIcons.trendingUp, size: 20, color: AppColors.info),
                                 ),
                                 title: Text(item, style: const TextStyle(fontWeight: FontWeight.w500)),
                                 trailing: const Icon(AppIcons.chevronRight, size: 14, color: Colors.grey),
                                 onTap: () {},
                               )).toList(),
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
