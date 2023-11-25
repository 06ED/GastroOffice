part of 'offer_list_bloc.dart';

@immutable
abstract class OfferListState {}

class OfferListInitial extends OfferListState {}

class OfferListInitState extends OfferListState {
  final List<OrderEntity> offers;

  OfferListInitState({required this.offers});
}
