part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class LoadDashboard extends ProductEvent {}

class LoadProductsByCategory extends ProductEvent {
  final String categoryId;
  const LoadProductsByCategory(this.categoryId);
  @override
  List<Object> get props => [categoryId];
}

class SearchProducts extends ProductEvent {
  final String query;
  const SearchProducts(this.query);
  @override
  List<Object> get props => [query];
}
