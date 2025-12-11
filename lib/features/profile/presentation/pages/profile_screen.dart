import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../features/auth/presentation/pages/login_screen.dart'; // For logout navigation
import 'order_history_screen.dart';
import 'settings_screen.dart';
import '../../../wishlist/presentation/pages/wishlist_screen.dart';
import '../../../shipping/presentation/pages/shipping_addresses_screen.dart';
import '../../../payment/presentation/pages/payment_methods_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ValueNotifier<String?> _profileImageNotifier = ValueNotifier(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  @override
  void dispose() {
    _profileImageNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    _profileImageNotifier.value = prefs.getString('profile_image_path');
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        final prefs = await SharedPreferences.getInstance();
        if (!mounted) return;
        await prefs.setString('profile_image_path', image.path);
        _profileImageNotifier.value = image.path;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(AppIcons.gallery),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(AppIcons.camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingLarge),
        child: Column(
          children: [
            // Avatar & Info
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ValueListenableBuilder<String?>(
                        valueListenable: _profileImageNotifier,
                        builder: (context, profileImagePath, _) => CircleAvatar(
                            radius: 60,
                            backgroundColor: Theme.of(context).disabledColor,
                            backgroundImage: profileImagePath != null
                                ? FileImage(File(profileImagePath))
                                : const NetworkImage('https://i.pravatar.cc/300') as ImageProvider,
                          ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showPickerOptions,
                          child: Container(
                            padding: const EdgeInsets.all(AppDimens.paddingSmall),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundDark,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.textDarkPrimary, width: 2),
                            ),
                            child: const Icon(AppIcons.camera, color: AppColors.textDarkPrimary, size: AppDimens.iconSmall),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.paddingMedium),
                  const Text(
                    'Jane Doe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text('jane.doe@example.com', style: TextStyle(color: AppColors.textLightSecondary)),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.p32),

            // Menu Options
            ListTile(
              leading: const Icon(AppIcons.orders),
              title: const Text('My Orders'),
              trailing: const Icon(AppIcons.chevronRight, size: AppDimens.iconSmall),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.favorite),
              title: const Text('Wishlist'),
              trailing: const Icon(AppIcons.chevronRight, size: AppDimens.iconSmall),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WishlistScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.location),
              title: const Text('Shipping Addresses'),
              trailing: const Icon(AppIcons.chevronRight, size: AppDimens.iconSmall),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ShippingAddressesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.card),
              title: const Text('Payment Methods'),
              trailing: const Icon(AppIcons.chevronRight, size: AppDimens.iconSmall),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
                );
              },
            ),

            const SizedBox(height: AppDimens.paddingLarge),
            ListTile(
              leading: const Icon(AppIcons.logout, color: AppColors.error),
              title: const Text('Logout', style: TextStyle(color: AppColors.error)),
              onTap: () {
                // In real app, dispatch LogoutEvent
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
}
