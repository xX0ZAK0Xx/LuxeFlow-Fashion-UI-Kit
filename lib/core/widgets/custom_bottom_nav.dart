import 'package:flutter/material.dart';

import '../constants/app_dimens.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final int cartCount;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartCount = 0,
  });

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimens.radiusLarge)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium, vertical: AppDimens.paddingMedium),
      child: SafeArea( 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, 0, AppIcons.home, AppIcons.homeActive, 'Home'),
            _buildNavItem(context, 1, AppIcons.explore, AppIcons.exploreActive, 'Explore'),
            _buildNavItem(context, 2, AppIcons.cart, AppIcons.cartActive, 'Cart', count: cartCount),
            _buildNavItem(context, 3, AppIcons.profile, AppIcons.profileActive, 'Profile'),
          ],
        ),
      ),
    );

  Widget _buildNavItem(BuildContext context, int index, IconData icon, IconData activeIcon, String label, {int count = 0}) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.1) : AppColors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (count > 0)
              Badge(
                label: Text('$count'),
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? Theme.of(context).primaryColor : AppColors.textLightSecondary,
                  size: AppDimens.iconMedium,
                ),
              )
            else
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? Theme.of(context).primaryColor : AppColors.textLightSecondary,
                size: AppDimens.iconMedium,
              ),
            if (isSelected) ...[
              const SizedBox(width: AppDimens.paddingSmall),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
