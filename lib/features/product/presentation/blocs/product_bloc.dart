import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetCategories getCategories;

  ProductBloc({
    required this.getProducts,
    required this.getCategories,
  }) : super(ProductInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<ProductState> emit,
  ) async {
    if (state is! DashboardLoaded) {
      emit(ProductLoading());
    }
    // Run both requests in parallel
    final results = await Future.wait([
      getCategories(NoParams()),
      getProducts(const GetProductsParams()),
    ]);

    final categoriesResult = results[0] as dynamic; // casting for ease, better pattern exists but keeping simple
    final productsResult = results[1] as dynamic;

    // Manual unpacking because of parallel execution return type
    List<CategoryEntity>? categories;
    List<ProductEntity>? products;
    String? error;

    categoriesResult.fold(
      (failure) => error = failure.message,
      (data) => categories = data,
    );

    productsResult.fold(
      (failure) => error = failure.message, // Priority to latest error
      (data) => products = data,
    );

    if (error != null) {
      emit(ProductError(error!));
    } else {
      emit(DashboardLoaded(
        categories: categories!,
        featuredProducts: products!,
      ));
    }
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProducts(GetProductsParams(categoryId: event.categoryId));
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProducts(GetProductsParams(searchQuery: event.query));
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductsLoaded(products)),
    );
  }
}
