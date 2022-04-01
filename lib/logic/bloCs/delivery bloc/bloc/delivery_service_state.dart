part of 'delivery_service_bloc.dart';

abstract class DeliveryServiceState {}

class DeliveryServiceInitial extends DeliveryServiceState {}

class Done extends DeliveryServiceState {}

class Error extends DeliveryServiceState {
  String error;
  Error({required this.error});
}
