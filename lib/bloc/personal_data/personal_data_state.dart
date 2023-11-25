part of 'personal_data_bloc.dart';

@immutable
abstract class PersonalDataState {}

class PersonalDataInitial extends PersonalDataState {}

class PersonalDataInitState extends PersonalDataState {
  final UserEntity user;

  PersonalDataInitState({required this.user});
}
