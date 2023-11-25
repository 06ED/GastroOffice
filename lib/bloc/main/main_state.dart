part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class MainInitState extends MainState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final bool needToSelectOrganization;

  MainInitState({
    required this.products,
    required this.categories,
    required this.needToSelectOrganization,
  });
}
