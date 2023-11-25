part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartInitState extends CartState {
  final List<ProductEntity> products;

  CartInitState({required this.products});
}
