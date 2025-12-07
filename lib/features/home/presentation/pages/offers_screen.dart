import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../product/presentation/blocs/product_bloc.dart';
import '../../../../features/product/presentation/pages/product_details_screen.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  late Timer _timer;
  final ValueNotifier<Duration> _timeLeftNotifier = ValueNotifier(
    const Duration(hours: 4, minutes: 25, seconds: 12),
  );

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeftNotifier.value.inSeconds > 0) {
        _timeLeftNotifier.value -= const Duration(seconds: 1);
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timeLeftNotifier.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String hours = twoDigits(d.inHours);
    String minutes = twoDigits(d.inMinutes.remainder(60));
    String seconds = twoDigits(d.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exclusive Offers')),
      body: CustomScrollView(
        slivers: [
          // Flash Sale Banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.grey[900]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                   const Text(
                     'FLASH SALE',
                     style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 24,
                       letterSpacing: 4,
                     ),
                   ),
                   const SizedBox(height: 8),
                   const Text(
                     'Ends in',
                     style: TextStyle(color: Colors.white70),
                   ),
                   const SizedBox(height: 12),
                   ValueListenableBuilder<Duration>(
                     valueListenable: _timeLeftNotifier,
                     builder: (context, timeLeft, _) {
                       return Text(
                         _formatDuration(timeLeft),
                         style: const TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: 32,
                           fontFamily: 'monospace'
                         ),
                       );
                     },
                   ),
                   const SizedBox(height: 16),
                   ElevatedButton(
                     onPressed: () {},
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white,
                       foregroundColor: Colors.black,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                     ),
                     child: const Text('Shop Now'),
                   ),
                ],
              ),
            ),
          ),

          // Grid
           SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is DashboardLoaded) {
                  // Filter for sale items for this example, ensuring we have products
                  final saleProducts = state.featuredProducts.take(6).toList(); // Ensure we always show something
                  
                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65, // Taller cards
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = saleProducts[index];
                        final heroTag = 'offers_sale_${product.id}';
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
                        );
                      },
                      childCount: saleProducts.length,
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
