import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

class CartItemCard extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium, vertical: AppDimens.paddingSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppDimens.r16),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: const [], // Removed shadow
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppDimens.r16),
                bottomLeft: Radius.circular(AppDimens.r16),
              ),
              child: CachedNetworkImage(
                imageUrl: item.product.imageUrl,
                width: 100,
                height: 120, // matching height roughly
                fit: BoxFit.cover,
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.radiusMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Delete
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.product.name,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                          onTap: onRemove,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(AppIcons.close, size: 20, color: Theme.of(context).disabledColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.p4),
                    
                    // Product Subtitle/Specs
                    if (item.selectedColor != null || item.selectedSize != null)
                      Text(
                        '${item.selectedColor ?? ''}${item.selectedColor != null && item.selectedSize != null ? ' | ' : ''}${item.selectedSize ?? ''}', 
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textLightSecondary),
                      )
                    else 
                      Text(
                         'Fashion', // Generic fallback
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textLightSecondary),
                      ),

                    const Spacer(),
                    
                    // Price & Quantity Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${item.product.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              _buildQtyBtn(AppIcons.remove, onDecrement),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                                child: Text(
                                  '${item.quantity}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              _buildQtyBtn(AppIcons.add, onIncrement),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: AppDimens.iconSmall, color: AppColors.textLightPrimary),
      ),
    );
}
