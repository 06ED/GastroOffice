part of 'select_organization_bloc.dart';

@immutable
abstract class SelectOrganizationState {}

class SelectOrganizationInitial extends SelectOrganizationState {}

class SelectOrganisationInitState extends SelectOrganizationState {
  final List<OrganizationEntity> organizations;

  SelectOrganisationInitState({required this.organizations});
}

class SelectedOrganisationState extends SelectOrganizationState {}
