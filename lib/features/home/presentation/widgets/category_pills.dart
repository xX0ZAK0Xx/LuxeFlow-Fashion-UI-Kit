import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../product/domain/entities/category_entity.dart';
import '../../../product/presentation/pages/category_list_screen.dart';
import '../../../product/presentation/pages/category_products_screen.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

class CategoryPills extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoryPills({super.key, required this.categories});

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
        itemCount: (categories.length > 5 ? 5 : categories.length) + 1, // Limit to 5 + "View All"
        itemBuilder: (context, index) {
          final displayCount = categories.length > 5 ? 5 : categories.length;
          if (index == displayCount) {
             return _buildViewAll(context);
          }
          final category = categories[index];
          return _buildPill(context, category);
        },
      ),
    );

  Widget _buildPill(BuildContext context, CategoryEntity category) => GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProductsScreen(category: category),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: AppDimens.radiusMedium),
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium, vertical: AppDimens.p8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
             Container(
               padding: const EdgeInsets.all(6),
               decoration: BoxDecoration(
                 color: Theme.of(context).colorScheme.surfaceContainerHighest,
                 shape: BoxShape.circle,
               ),
               child: category.icon != null 
                 ? Icon(category.icon, size: AppDimens.iconSmall, color: Theme.of(context).iconTheme.color)
                 : ClipOval(
                     child: CachedNetworkImage(
                       imageUrl: category.imageUrl,
                       width: AppDimens.iconSmall,
                       height: AppDimens.iconSmall,
                       fit: BoxFit.cover,
                       errorWidget: (context, url, error) => const Icon(AppIcons.error, size: AppDimens.iconSmall),
                     ),
                   ),
             ),
             const SizedBox(width: AppDimens.paddingSmall),
             Text(
               category.name,
               style: const TextStyle(fontWeight: FontWeight.w600),
             ),
          ],
        ),
      ),
    );

  Widget _buildViewAll(BuildContext context) => GestureDetector(
      onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryListScreen()));
      },
      child: Container(
        margin: const EdgeInsets.only(right: AppDimens.radiusMedium),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: AppDimens.p8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Text(
          'View All',
          style: TextStyle(color: AppColors.textDarkPrimary, fontWeight: FontWeight.bold),
        ),
      ),
    );
}
