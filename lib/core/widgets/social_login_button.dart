import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 16),
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
             Image.asset(assetPath, width: 24, height: 24, errorBuilder: (c,o,s) => const Icon(Icons.public, size: 24)),
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
