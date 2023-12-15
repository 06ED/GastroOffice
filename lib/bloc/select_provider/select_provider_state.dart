part of 'select_provider_bloc.dart';

@immutable
abstract class SelectProviderState {}

class SelectProviderInitial extends SelectProviderState {}

class SelectProviderInitState extends SelectProviderState {
  final List<ProviderEntity> providers;

  SelectProviderInitState({required this.providers});
}
