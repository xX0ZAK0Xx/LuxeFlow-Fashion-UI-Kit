import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'features/cart/presentation/blocs/cart_bloc.dart';
import 'features/product/presentation/blocs/product_bloc.dart';
import 'features/wishlist/presentation/blocs/wishlist_bloc.dart';
import 'features/shipping/presentation/blocs/shipping_bloc.dart';
import 'features/payment/presentation/blocs/payment_bloc.dart';
import 'features/notification/presentation/blocs/notification_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/bloc/theme_bloc.dart';

// import 'features/auth/presentation/pages/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<ThemeBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<CartBloc>()..add(LoadCart()),
        ), 
        BlocProvider(
          create: (_) => di.sl<ProductBloc>()..add(LoadDashboard()),
        ),
        BlocProvider(
          create: (_) => WishlistBloc()..add(LoadWishlist()),
        ),
        BlocProvider(
          create: (_) => di.sl<ShippingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<PaymentBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<NotificationBloc>()..add(LoadNotifications()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'LuxeFlow',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            // home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
