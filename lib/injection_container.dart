import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/cart/data/datasources/cart_local_data_source.dart';
import 'features/product/data/datasources/product_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/cart/domain/usecases/cart_usecases.dart';
import 'features/product/domain/usecases/get_products.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'features/cart/presentation/blocs/cart_bloc.dart';
import 'features/product/presentation/blocs/product_bloc.dart';
import 'core/theme/bloc/theme_bloc.dart';

import 'features/shipping/data/datasources/shipping_local_data_source.dart';
import 'features/shipping/data/repositories/shipping_repository_impl.dart';
import 'features/shipping/domain/repositories/shipping_repository.dart';
import 'features/shipping/domain/usecases/shipping_usecases.dart';
import 'features/shipping/presentation/blocs/shipping_bloc.dart';

import 'features/notification/data/datasources/notification_local_data_source.dart';
import 'features/notification/data/repositories/notification_repository_impl.dart';
import 'features/notification/domain/repositories/notification_repository.dart';
import 'features/notification/domain/usecases/notification_usecases.dart';
import 'features/notification/presentation/blocs/notification_bloc.dart';

import 'features/payment/data/datasources/payment_local_data_source.dart';
import 'features/payment/data/repositories/payment_repository_impl.dart';
import 'features/payment/domain/repositories/payment_repository.dart';
import 'features/payment/domain/usecases/payment_usecases.dart';
import 'features/payment/presentation/blocs/payment_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Theme
  sl..registerFactory(() => ThemeBloc(sharedPreferences: sl()))

  // Features - Auth
  ..registerFactory(() => AuthBloc(loginUser: sl()))
  ..registerLazySingleton(() => LoginUser(sl()))
  ..registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  )
  ..registerLazySingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl.new,
  )

  // Features - Product
  ..registerFactory(
    () => ProductBloc(
      getProducts: sl(),
      getCategories: sl(),
    ),
  )
  ..registerLazySingleton(() => GetProducts(sl()))
  ..registerLazySingleton(() => GetCategories(sl()))
  ..registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(localDataSource: sl()),
  )
  ..registerLazySingleton<ProductLocalDataSource>(
    ProductLocalDataSourceImpl.new,
  )

  // Features - Cart
  ..registerLazySingleton(
    () => CartBloc(
      getCart: sl(),
      addToCart: sl(),
      removeFromCart: sl(),
      updateCartItem: sl(),
    ),
  )
  ..registerLazySingleton(() => GetCart(sl()))
  ..registerLazySingleton(() => AddToCart(sl()))
  ..registerLazySingleton(() => RemoveFromCart(sl()))
  ..registerLazySingleton(() => UpdateCartItem(sl()))
  ..registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl()),
  )
  ..registerLazySingleton<CartLocalDataSource>(
    CartLocalDataSourceImpl.new,
  )

  // Features - Shipping
  ..registerFactory(
    () => ShippingBloc(
      getAddresses: sl(),
      addAddress: sl(),
      deleteAddress: sl(),
    ),
  )
  ..registerLazySingleton(() => GetShippingAddresses(sl()))
  ..registerLazySingleton(() => AddShippingAddress(sl()))
  ..registerLazySingleton(() => DeleteShippingAddress(sl()))
  ..registerLazySingleton<ShippingRepository>(
    () => ShippingRepositoryImpl(localDataSource: sl()),
  )
  ..registerLazySingleton<ShippingLocalDataSource>(
    ShippingLocalDataSourceImpl.new,
  )

  // Features - Payment
  ..registerFactory(
    () => PaymentBloc(
      getMethods: sl(),
      addMethod: sl(),
      deleteMethod: sl(),
    ),
  )
  ..registerLazySingleton(() => GetPaymentMethods(sl()))
  ..registerLazySingleton(() => AddPaymentMethod(sl()))
  ..registerLazySingleton(() => DeletePaymentMethod(sl()))
  ..registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(localDataSource: sl()),
  )
  ..registerLazySingleton<PaymentLocalDataSource>(
    PaymentLocalDataSourceImpl.new,
  )

  // Features - Notification
  ..registerFactory(
    () => NotificationBloc(
      getNotifications: sl(),
      markAllAsRead: sl(),
      markAsRead: sl(),
    ),
  )
  ..registerLazySingleton(() => GetNotifications(sl()))
  ..registerLazySingleton(() => MarkAllNotificationsAsRead(sl()))
  ..registerLazySingleton(() => MarkNotificationAsRead(sl()))
  ..registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(localDataSource: sl()),
  )
  ..registerLazySingleton<NotificationLocalDataSource>(
    NotificationLocalDataSourceImpl.new,
  );

  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
