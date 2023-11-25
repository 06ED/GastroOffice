part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}


class AddToCartProductEvent extends ProductEvent {
  final List<ProductEntity> products;

  AddToCartProductEvent({required this.products});
}