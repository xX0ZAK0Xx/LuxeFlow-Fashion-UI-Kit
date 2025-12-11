import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../features/product/domain/entities/product_entity.dart';
import '../constants/app_dimens.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final String? heroTag;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: const [], // Removed shadow
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                   ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimens.radiusMedium)),
                    child: Hero(
                      tag: heroTag ?? 'product_image_${product.id}',
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        memCacheHeight: 600,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(color: AppColors.backgroundLight),
                        ),
                        errorWidget: (context, url, error) => const Icon(AppIcons.error),
                      ),
                    ),
                  ),
                  if (product.isNew)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('NEW', style: TextStyle(color: AppColors.textDarkPrimary, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  if (product.isSale)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('-20%', style: TextStyle(color: AppColors.textDarkPrimary, fontSize: 10, fontWeight: FontWeight.bold)), // Mock discount
                      ),
                    ),
                    
                  // Floating Add Button
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1), 
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: const Icon(AppIcons.add, color: AppColors.textLightPrimary, size: AppDimens.iconSmall),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Details Section
            Padding(
              padding: const EdgeInsets.all(AppDimens.radiusMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  
                  // Category / Brand Mock
                  Text(
                    'Luxe Brand', 
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textLightSecondary),
                  ),
                  const SizedBox(height: AppDimens.paddingSmall),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      Row(
                        children: [
                          const Icon(AppIcons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: AppDimens.p4),
                          Text(
                            product.rating.toString(),
                             style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
