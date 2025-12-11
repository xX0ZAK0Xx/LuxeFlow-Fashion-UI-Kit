import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final ValueNotifier<RangeValues> _priceRangeNotifier = ValueNotifier(const RangeValues(20, 100));
  final ValueNotifier<String?> _selectedColorNameNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _selectedSizeNotifier = ValueNotifier(null);
  
  final List<Map<String, dynamic>> _colors = [
    {'name': 'Black', 'color': Colors.black},
    {'name': 'White', 'color': Colors.white},
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Beige', 'color': const Color(0xFFF5F5DC)},
  ];
  
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];

  @override
  void dispose() {
    _priceRangeNotifier.dispose();
    _selectedColorNameNotifier.dispose();
    _selectedSizeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters', 
                style: GoogleFonts.bodoniModa(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold
                ),
              ),
              TextButton(
                onPressed: () {
                  _priceRangeNotifier.value = const RangeValues(0, 500);
                  _selectedColorNameNotifier.value = null;
                  _selectedSizeNotifier.value = null;
                },
                child: Text(
                  'Reset', 
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Price Range
          Text(
            'Price Range', 
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<RangeValues>(
            valueListenable: _priceRangeNotifier,
            builder: (context, priceRange, _) {
              return Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${priceRange.start.round()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('\$${priceRange.end.round()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: 500,
                    divisions: 50,
                    activeColor: Theme.of(context).colorScheme.onSurface,
                    inactiveColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                    onChanged: (values) {
                      _priceRangeNotifier.value = values;
                    },
                  ),
                ],
              );
            },
          ),
          
          const SizedBox(height: 24),
          
          // Colors
          Text(
            'Colors', 
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<String?>(
            valueListenable: _selectedColorNameNotifier,
            builder: (context, selectedColorName, _) {
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _colors.map((colorItem) {
                  final colorName = colorItem['name'] as String;
                  final colorValue = colorItem['color'] as Color;
                  final isSelected = selectedColorName == colorName;
                  
                  return GestureDetector(
                    onTap: () {
                      _selectedColorNameNotifier.value = isSelected ? null : colorName;
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorValue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.grey.withValues(alpha: 0.3),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: colorValue.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                        ],
                      ),
                      child: isSelected && colorValue == Colors.white 
                          ? const Icon(Icons.check, size: 20, color: Colors.black)
                          : isSelected 
                            ? const Icon(Icons.check, size: 20, color: Colors.white)
                            : null,
                    ),
                  );
                }).toList(),
              );
            },
          ),
          
          const SizedBox(height: 24),
          
          // Sizes
          Text(
            'Sizes', 
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<String?>(
            valueListenable: _selectedSizeNotifier,
            builder: (context, selectedSize, _) {
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _sizes.map((size) {
                  final isSelected = selectedSize == size;
                  return GestureDetector(
                    onTap: () {
                       _selectedSizeNotifier.value = isSelected ? null : size;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.grey.shade300,
                        ),
                        boxShadow: isSelected ? [
                          BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                        ] : [],
                      ),
                      child: Text(
                        size,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          
          const SizedBox(height: 40),
          
          // Apply Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                ),
              ),
              child: const Text('Apply Filters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
