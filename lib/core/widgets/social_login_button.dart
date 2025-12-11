import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../constants/app_icons.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final String assetPath;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          // border: Border.all(color: Colors.grey.shade300),
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Assuming we have assets, but for now using Icons if asset logic not fully set up
            // Or typically simple image asset
             Image.asset(assetPath, width: AppDimens.iconMedium, height: AppDimens.iconMedium, errorBuilder: (c,o,s) => const Icon(AppIcons.socialGlobal, size: AppDimens.iconMedium)),
            const SizedBox(width: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
}
