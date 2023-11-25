part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainInitEvent extends MainEvent {}

class UpdateCategoryEvent extends MainEvent {
  final CategoryEntity category;

  UpdateCategoryEvent({required this.category});
}
