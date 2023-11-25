part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitEvent extends CartEvent {}

class DeleteProductFromCartEvent extends CartEvent {
  final ProductEntity product;

  DeleteProductFromCartEvent({required this.product});
}

class CreateNewOrderFromCartEvent extends CartEvent {
  final bool delivery;

  CreateNewOrderFromCartEvent({required this.delivery});
}
