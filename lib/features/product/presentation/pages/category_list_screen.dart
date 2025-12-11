import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_products_screen.dart';
import '../blocs/product_bloc.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('All Categories')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            final categories = state.categories;
            return GridView.builder(
              padding: const EdgeInsets.all(AppDimens.paddingMedium),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppDimens.paddingMedium,
                mainAxisSpacing: AppDimens.paddingMedium,
                childAspectRatio: 1.1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                   onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryProductsScreen(category: category),
                      ),
                    );
                   },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.r16),
                      border: Border.all(color: Theme.of(context).dividerColor),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          category.imageUrl,
                          maxHeight: 400, // Memory optimization
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.3),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      category.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textDarkPrimary,
                            fontWeight: FontWeight.bold,
                            shadows: [const Shadow(color: Colors.black45, blurRadius: 4)],
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          } else {
             return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
}
