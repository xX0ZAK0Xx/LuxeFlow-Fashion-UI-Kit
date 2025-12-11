import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../product/presentation/blocs/product_bloc.dart';
import '../../../../features/product/presentation/pages/product_details_screen.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';

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
    final String hours = twoDigits(d.inHours);
    final String minutes = twoDigits(d.inMinutes.remainder(60));
    final String seconds = twoDigits(d.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Exclusive Offers')),
      body: CustomScrollView(
        slivers: [
          // Flash Sale Banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(AppDimens.paddingMedium),
              padding: const EdgeInsets.all(AppDimens.paddingLarge),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.surfaceDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppDimens.r16),
              ),
              child: Column(
                children: [
                   const Text(
                     'FLASH SALE',
                     style: TextStyle(
                       color: AppColors.textDarkPrimary,
                       fontWeight: FontWeight.bold,
                       fontSize: 24,
                       letterSpacing: 4,
                     ),
                   ),
                   const SizedBox(height: AppDimens.paddingSmall),
                   const Text(
                     'Ends in',
                     style: TextStyle(color: AppColors.textDarkSecondary),
                   ),
                   const SizedBox(height: AppDimens.paddingMedium),
                   ValueListenableBuilder<Duration>(
                     valueListenable: _timeLeftNotifier,
                     builder: (context, timeLeft, _) => Text(
                         _formatDuration(timeLeft),
                         style: const TextStyle(
                           color: AppColors.textDarkPrimary,
                           fontWeight: FontWeight.bold,
                           fontSize: 32,
                           fontFamily: 'monospace'
                         ),
                       ),
                   ),
                   const SizedBox(height: AppDimens.paddingMedium),
                   ElevatedButton(
                     onPressed: () {},
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppColors.surfaceLight,
                       foregroundColor: AppColors.textLightPrimary,
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
            padding: const EdgeInsets.all(AppDimens.paddingMedium),
            sliver: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is DashboardLoaded) {
                  // Filter for sale items for this example, ensuring we have products
                  final saleProducts = state.featuredProducts.take(6).toList(); // Ensure we always show something
                  
                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65, // Taller cards
                      mainAxisSpacing: AppDimens.paddingMedium,
                      crossAxisSpacing: AppDimens.paddingMedium,
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
