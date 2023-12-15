part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainInitEvent extends MainEvent {
  final ProviderEntity provider;

  MainInitEvent({required this.provider});
}

class UpdateCategoryEvent extends MainEvent {
  final CategoryEntity category;

  UpdateCategoryEvent({required this.category});
}
