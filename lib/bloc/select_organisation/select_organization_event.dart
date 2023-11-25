part of 'select_organization_bloc.dart';

@immutable
abstract class SelectOrganizationEvent {}

class SelectOrganizationInitEvent extends SelectOrganizationEvent {}

class OnSelectOrganizationEvent extends SelectOrganizationEvent {
  final OrganizationEntity organization;

  OnSelectOrganizationEvent({required this.organization});
}
