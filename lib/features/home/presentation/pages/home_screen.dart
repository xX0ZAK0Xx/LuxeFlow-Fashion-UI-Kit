import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../../features/product/presentation/blocs/product_bloc.dart';
import '../../../notification/presentation/pages/notification_screen.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import '../../../product/presentation/pages/search_screen.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../../../../features/product/presentation/pages/product_details_screen.dart';
import '../../../../features/cart/presentation/blocs/cart_bloc.dart';
import '../../../wishlist/presentation/blocs/wishlist_bloc.dart';
import '../../../wishlist/presentation/pages/wishlist_screen.dart';
import '../widgets/hero_banner.dart';
import '../widgets/category_pills.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeFeed(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow content to go behind status bar
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          int cartCount = 0;
          if (cartState is CartLoaded) {
            cartCount = cartState.items.fold(0, (sum, item) => sum + item.quantity);
          }
          return CustomBottomNav(
            currentIndex: _currentIndex,
            cartCount: cartCount,
            onTap: (index) {
              if (index == 0) {
                 context.read<ProductBloc>().add(LoadDashboard());
              }
              setState(() {
                _currentIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}


class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data for Carousel
    final List<String> bannerImages = [
      'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=2070&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=2020&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?q=80&w=2070&auto=format&fit=crop',
    ];

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardLoaded) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 320.0,
                    floating: false,
                    pinned: true,
                    stretch: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    systemOverlayStyle: SystemUiOverlayStyle.light, // Ensure inner AppBar respects it too
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin, // Keeps it pinned behind status bar
                      background: SizedBox(
                         height: 400, // Explicit large height
                         child: HeroBanner(imageUrls: bannerImages, height: 400),
                      ),
                      stretchModes: const [
                         StretchMode.zoomBackground,
                         StretchMode.blurBackground,
                      ],
                    ),
                    title: const Text(
                      'LuxeFlow', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: Colors.white, 
                        shadows: [Shadow(color: Colors.black45, blurRadius: 5)],
                      ),
                    ),
                    actions: [
                       BlocBuilder<WishlistBloc, WishlistState>(
                         builder: (context, wishlistState) {
                           int wishlistCount = 0;
                           if (wishlistState is WishlistLoaded) {
                             wishlistCount = wishlistState.wishlist.length;
                           }
                           return IconButton(
                            icon: wishlistCount > 0 
                              ? Badge(
                                  label: Text('$wishlistCount'),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  child: const Icon(Icons.favorite_border, color: Colors.white, shadows: [Shadow(color: Colors.black45, blurRadius: 5)]),
                                )
                              : const Icon(Icons.favorite_border, color: Colors.white, shadows: [Shadow(color: Colors.black45, blurRadius: 5)]),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistScreen()));
                            },
                          );
                         },
                       ),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: Colors.white, shadows: [Shadow(color: Colors.black45, blurRadius: 5)]), 
                        onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
                        },
                      ),
                    ],
                  ),
                  
                  // Categories
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 32),
                      child: CategoryPills(categories: state.categories),
                    ),
                  ),
                  
                  // New Arrivals Header
                  SliverToBoxAdapter(
                    child: SectionHeader(title: 'New Arrivals', onViewAll: () {}),
                  ),
                  
                   // New Arrivals List (Horizontal)
                  SliverToBoxAdapter(
                    child: Container(
                      height: 320, // Increased height for taller cards
                      margin: const EdgeInsets.only(top: 16, bottom: 32),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.featuredProducts.length,
                        itemBuilder: (context, index) {
                          final product = state.featuredProducts[index];
                          return Container(
                            width: 180, // Slightly wider
                            margin: const EdgeInsets.only(right: 16),
                            child: ProductCard(
                              product: product,
                              onTap: () => navigateToProduct(context, product),
                              onAddToCart: () => addToCart(context, product),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
  
                  // Best Sellers Header
                  SliverToBoxAdapter(
                    child: const SectionHeader(title: 'Best Sellers'),
                  ),
                  
                  // Best Sellers Grid
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), // Bottom padding for Nav
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65, // Taller aspect ratio for new design
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 24, // More spacing
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                           // Show random products to simulate Best Sellers
                           final product = state.featuredProducts[index % state.featuredProducts.length];
                           return ProductCard(
                            product: product,
                            onTap: () => navigateToProduct(context, product),
                            onAddToCart: () => addToCart(context, product),
                          );
                        },
                        childCount: state.featuredProducts.length * 2, // Fake more content
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ProductError) {
               return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
    );
  }

  void navigateToProduct(BuildContext context, dynamic product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
    );
  }

  void addToCart(BuildContext context, dynamic product) {
    context.read<CartBloc>().add(AddProductToCart(product));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
