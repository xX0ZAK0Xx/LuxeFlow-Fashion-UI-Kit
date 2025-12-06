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

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Theme
  sl.registerFactory(() => ThemeBloc(sharedPreferences: sl()));

  // Features - Auth
  sl.registerFactory(() => AuthBloc(loginUser: sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  // Features - Product
  sl.registerFactory(
    () => ProductBloc(
      getProducts: sl(),
      getCategories: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(),
  );

  // Features - Cart
  sl.registerLazySingleton(
    () => CartBloc(
      getCart: sl(),
      addToCart: sl(),
      removeFromCart: sl(),
      updateCartItem: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCart(sl()));
  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => RemoveFromCart(sl()));
  sl.registerLazySingleton(() => UpdateCartItem(sl()));
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(),
  );

  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
