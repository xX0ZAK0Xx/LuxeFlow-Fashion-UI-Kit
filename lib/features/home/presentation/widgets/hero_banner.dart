import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import 'package:shimmer/shimmer.dart';



class HeroBanner extends StatelessWidget {
  final List<String> imageUrls;
  final double height;

  const HeroBanner({super.key, required this.imageUrls, this.height = 300});

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: const BorderRadiusGeometry.vertical(
        bottom: Radius.circular(AppDimens.radiusLarge),
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
        ),
        items: imageUrls.map((url) => Builder(
            builder: (BuildContext context) => Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Shimmer.fromColors(
                       baseColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                       highlightColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                       child: Container(color: Theme.of(context).cardColor),
                    ),
                    errorWidget: (context, url, error) => const Icon(AppIcons.error),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NEW SEASON',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.textDarkPrimary,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: AppDimens.paddingSmall),
                        Text(
                          'Autumn Collection\n2025',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: AppColors.textDarkPrimary,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                        ),
                        const SizedBox(height: AppDimens.paddingMedium),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceLight,
                            foregroundColor: AppColors.textLightPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge, vertical: AppDimens.radiusMedium),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('SHOP NOW'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          )).toList(),
      ),
    );
}
